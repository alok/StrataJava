from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CORPUS = ROOT / "metadata" / "corpus.json"
SRC_DIR = ROOT / "corpus" / "cs61b-java" / "src"
CLASSES_DIR = ROOT / "build" / "classes" / "cs61b-java"


def load_programs() -> list[dict[str, object]]:
    with CORPUS.open(encoding="utf-8") as handle:
        corpus = json.load(handle)
    programs = corpus.get("programs")
    if not isinstance(programs, list):
        raise TypeError("metadata/corpus.json must contain a programs list")
    return programs


def compile_corpus() -> None:
    sources = sorted(str(path) for path in SRC_DIR.glob("*.java"))
    if not sources:
        raise FileNotFoundError(f"no Java sources under {SRC_DIR}")
    CLASSES_DIR.mkdir(parents=True, exist_ok=True)
    subprocess.run(["javac", "-d", str(CLASSES_DIR), *sources], cwd=ROOT, check=True)


def extract_main_snippet(path: Path) -> list[tuple[int, str]]:
    lines = path.read_text(encoding="utf-8").splitlines()
    start = None
    for index, line in enumerate(lines):
        if re.search(r"\bpublic\s+static\s+void\s+main\s*\(", line):
            start = index
            break
    if start is None:
        raise ValueError(f"{path.relative_to(ROOT)} has no public static void main")

    depth = 0
    seen_open = False
    snippet: list[tuple[int, str]] = []
    for index in range(start, len(lines)):
        line = lines[index]
        snippet.append((index + 1, line))
        if "{" in line:
            seen_open = True
        depth += line.count("{") - line.count("}")
        if seen_open and depth == 0:
            return snippet
    raise ValueError(f"{path.relative_to(ROOT)} main method did not close")


def run_class(class_name: str) -> str:
    completed = subprocess.run(
        ["java", "-cp", str(CLASSES_DIR), class_name],
        cwd=ROOT,
        text=True,
        capture_output=True,
        timeout=10,
    )
    if completed.returncode != 0:
        sys.stderr.write(completed.stderr)
        raise RuntimeError(f"{class_name} exited with {completed.returncode}")
    return completed.stdout


def print_block(label: str, text: str) -> None:
    print(f"{label}:")
    if text:
        for line in text.rstrip("\n").splitlines():
            print(f"  {line}")
    else:
        print("  <empty>")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Run each Java corpus main method and print the main source next to stdout."
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="only report the final count; still fails if any main method is missing or exits nonzero",
    )
    parser.add_argument(
        "--no-compile",
        action="store_true",
        help="use the existing compiled classes instead of compiling first",
    )
    args = parser.parse_args()

    if not args.no_compile:
        compile_corpus()

    programs = load_programs()
    failures: list[str] = []
    for program in sorted(programs, key=lambda item: str(item["file"])):
        rel = str(program["file"])
        path = ROOT / rel
        class_name = path.stem
        try:
            snippet = extract_main_snippet(path)
            stdout = run_class(class_name)
        except Exception as exc:
            failures.append(f"{class_name}: {exc}")
            continue

        if not args.quiet:
            print(f"== {class_name} ==")
            print(f"source: {rel}")
            if "source_probe" in program:
                print(f"probe: {program['source_probe']}")
            if "topic" in program:
                print(f"topic: {program['topic']}")
            print("main:")
            width = max(len(str(line_no)) for line_no, _ in snippet)
            for line_no, line in snippet:
                print(f"  {line_no:>{width}} | {line}")
            print_block("stdout", stdout)
            print()

    if failures:
        for failure in failures:
            print(failure, file=sys.stderr)
        raise SystemExit(1)

    print(f"Ran {len(programs)} Java main examples successfully.")


if __name__ == "__main__":
    main()
