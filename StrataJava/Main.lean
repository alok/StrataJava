import StrataJava
import StrataMainLib

namespace StrataJava

def looksLikeStrataFileArg (arg : String) : Bool :=
  arg.endsWith ".st"

def ensureCoreSketchArg (args : List String) : List String :=
  if args.any looksLikeStrataFileArg then
    args
  else
    args ++ [coreSketchPath]

/--
Normalize short corpus-focused invocations into Strata's own CLI.

Examples:
- `lake exe stratajava` runs `strata verify --type-check CoreSketch.core.st`.
- `lake exe stratajava --parse-only` runs Strata parse/typecheck on the sketch.
- `lake exe stratajava --solver z3 --check-level full` runs solver-backed verification.
- `lake exe stratajava verify ...` forwards an explicit Strata command.
-/
def normalizeArgs (args : List String) : List String :=
  match args with
  | [] => ["verify", "--type-check", coreSketchPath]
  | "verify" :: rest => "verify" :: ensureCoreSketchArg rest
  | _ => "verify" :: ensureCoreSketchArg args

end StrataJava

def main (args : List String) : IO Unit :=
  runCommandMap commandMap commandGroups (StrataJava.normalizeArgs args)
