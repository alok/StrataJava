from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
CORPUS = ROOT / "metadata" / "corpus.json"
SEMANTICS = ROOT / "semantics" / "cs61b-java" / "stack-semantics.json"
CORE_SKETCH = ROOT / "semantics" / "strata-core" / "cs61b-java" / "CoreSketch.core.st"

EXPECTED_PROGRAMS = 50
REQUIRED_LAYERS = {"surface", "functional", "operational", "verification", "strata_core"}
REQUIRED_CHAIN = [
    ("C0.source_to_surface", "L0.source", "L1.surface"),
    ("C1.surface_to_functional", "L1.surface", "L2.functional"),
    ("C2.functional_to_operational", "L2.functional", "L3.operational"),
    ("C3.operational_to_verification", "L3.operational", "L4.verification"),
    ("C4.verification_to_strata_core", "L4.verification", "L5.strata_core"),
]
FORBIDDEN_SOURCE_TOKENS = re.compile(r"\b(throw|throws|try|catch|Exception|while)\b|recurs", re.IGNORECASE)
PUBLIC_METHOD = re.compile(
    r"\bpublic\s+(?:static\s+)?(?:[A-Za-z0-9_\[\]]+|void)\s+([A-Za-z0-9_]+)\s*\("
)


def load_json(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as handle:
        value = json.load(handle)
    if not isinstance(value, dict):
        raise TypeError(f"{path} must contain a JSON object")
    return value


def java_sources_from_corpus() -> set[str]:
    corpus = load_json(CORPUS)
    programs = corpus.get("programs")
    if not isinstance(programs, list):
        raise TypeError("metadata/corpus.json must contain a programs list")
    sources = {program["file"] for program in programs}
    if len(sources) != EXPECTED_PROGRAMS:
        raise ValueError(f"expected {EXPECTED_PROGRAMS} corpus programs, got {len(sources)}")

    actual_sources = {
        str(path.relative_to(ROOT))
        for path in (ROOT / "corpus" / "cs61b-java" / "src").glob("*.java")
    }
    if actual_sources != sources:
        missing = sorted(sources - actual_sources)
        extra = sorted(actual_sources - sources)
        raise ValueError(f"metadata/source mismatch missing={missing} extra={extra}")

    for source in sources:
        source_path = ROOT / source
        if not source_path.exists():
            raise FileNotFoundError(source)
        text = source_path.read_text(encoding="utf-8")
        match = FORBIDDEN_SOURCE_TOKENS.search(text)
        if match:
            raise ValueError(f"{source} contains forbidden token {match.group(0)!r}")
    return sources


def validate_semantics(sources: set[str]) -> None:
    semantics = load_json(SEMANTICS)
    chain = semantics.get("semantic_chain")
    if not isinstance(chain, list):
        raise TypeError("semantic_chain must be a list")
    observed_chain = [(link.get("id"), link.get("from"), link.get("to")) for link in chain]
    if observed_chain != REQUIRED_CHAIN:
        raise ValueError(f"semantic_chain must be the ordered chain {REQUIRED_CHAIN}")
    for link in chain:
        for key in ("consumes", "emits", "obligation"):
            value = link.get(key)
            if not isinstance(value, str) or not value:
                raise ValueError(f"{link.get('id')} must define nonempty {key}")

    required = set(semantics.get("required_method_layers", []))
    if required != REQUIRED_LAYERS:
        raise ValueError(f"required_method_layers must be {sorted(REQUIRED_LAYERS)}")

    programs = semantics.get("programs")
    if not isinstance(programs, list):
        raise TypeError("semantics programs must be a list")

    semantic_sources = {program["source_file"] for program in programs}
    if semantic_sources != sources:
        missing = sorted(sources - semantic_sources)
        extra = sorted(semantic_sources - sources)
        raise ValueError(f"semantics/source mismatch missing={missing} extra={extra}")

    core_text = CORE_SKETCH.read_text(encoding="utf-8")
    total_methods = 0
    for program in programs:
        source_path = ROOT / program["source_file"]
        java_text = source_path.read_text(encoding="utf-8")
        public_methods = {
            name
            for name in PUBLIC_METHOD.findall(java_text)
            if name != "main" and name != program["class"]
        }
        methods = program.get("methods")
        if not isinstance(methods, list) or not methods:
            raise ValueError(f"{program['class']} must have at least one method")
        semantic_methods = {method.get("name") for method in methods}
        if semantic_methods != public_methods:
            missing = sorted(public_methods - semantic_methods)
            stale = sorted(semantic_methods - public_methods)
            raise ValueError(
                f"{program['class']} method mismatch missing_semantics={missing} stale_semantics={stale}"
            )
        for method in methods:
            total_methods += 1
            layers = method.get("layers")
            if not isinstance(layers, dict):
                raise TypeError(f"{program['class']}.{method['name']} layers must be an object")
            if set(layers) != REQUIRED_LAYERS:
                raise ValueError(f"{program['class']}.{method['name']} layer mismatch")
            procedure = layers["strata_core"]
            if not isinstance(procedure, str) or not procedure:
                raise ValueError(f"{program['class']}.{method['name']} missing strata_core procedure")
            if f"procedure {procedure}" not in core_text:
                raise ValueError(f"{procedure} is missing from {CORE_SKETCH}")

    if total_methods < 30:
        raise ValueError(f"expected a rich method semantics set, got {total_methods}")


def main() -> None:
    sources = java_sources_from_corpus()
    validate_semantics(sources)
    print(f"Validated chained stack semantics for {len(sources)} Java programs.")


if __name__ == "__main__":
    main()
