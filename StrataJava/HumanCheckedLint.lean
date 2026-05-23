import Lean

namespace StrataJava.HumanCheckedLint

def defaultCorpusDir : System.FilePath :=
  "corpus/cs61b-java/src"

structure Warning where
  file : System.FilePath
  lineNo : Nat
  line : String

def trim (s : String) : String :=
  s.trimAscii.copy

def containsSubstr (needle haystack : String) : Bool :=
  match haystack.splitOn needle with
  | [_] => false
  | _ => true

def extractClassName (line : String) : Option String :=
  let parts := trim line |>.splitOn " "
  let rec afterClass : List String -> Option String
    | [] => none
    | "class" :: name :: _ => some name
    | _ :: rest => afterClass rest
  afterClass parts

def firstClassName : List String -> Option String
  | [] => none
  | line :: rest =>
      match extractClassName line with
      | some name => some name
      | none => firstClassName rest

def isMainMethod (trimmed : String) : Bool :=
  containsSubstr " main(" trimmed || containsSubstr " main (" trimmed

def isConstructor (className : String) (trimmed : String) : Bool :=
  trimmed.startsWith s!"public {className}("
    || trimmed.startsWith s!"public {className} ("

def isPublicFunctionLine (className : String) (line : String) : Bool :=
  let trimmed := trim line
  trimmed.startsWith "public "
    && !trimmed.startsWith "public class "
    && !isMainMethod trimmed
    && !isConstructor className trimmed
    && containsSubstr "(" trimmed
    && containsSubstr ")" trimmed
    && containsSubstr "{" trimmed

def hasHumanCheckedMarker (line : String) : Bool :=
  containsSubstr "human-checked" line

partial def scanLines (file : System.FilePath) (className : String)
    (lines : List String) (lineNo : Nat) (recent : List String)
    (warnings : List Warning) : List Warning :=
  match lines with
  | [] => warnings.reverse
  | line :: rest =>
      let nearby := line :: recent
      let missingMarker :=
        isPublicFunctionLine className line
          && !nearby.any hasHumanCheckedMarker
      let warnings :=
        if missingMarker then
          { file := file, lineNo := lineNo, line := trim line } :: warnings
        else
          warnings
      scanLines file className rest (lineNo + 1) (nearby.take 4) warnings

def lintFile (file : System.FilePath) (content : String) : List Warning :=
  let lines := content.splitOn "\n"
  match firstClassName lines with
  | some className => scanLines file className lines 1 [] []
  | none => []

def isJavaFile (path : System.FilePath) : Bool :=
  path.toString.endsWith ".java"

def lintDirectory (dir : System.FilePath) : IO (List Warning) := do
  let entries <- dir.readDir
  let mut warnings : List Warning := []
  for entry in entries do
    let path := entry.path
    if isJavaFile path then
      let content <- IO.FS.readFile path
      warnings := warnings ++ lintFile path content
  pure warnings

def lintPath (path : System.FilePath) : IO (List Warning) := do
  if (← path.isDir) then
    lintDirectory path
  else if isJavaFile path then
    let content <- IO.FS.readFile path
    pure (lintFile path content)
  else
    pure []

def Warning.render (warning : Warning) : String :=
  s!"{warning.file}:{warning.lineNo}: warning: public function lacks nearby `human-checked` comment: {warning.line}"

def run (args : List String) : IO Unit := do
  let argPaths : List System.FilePath :=
    args.map (fun arg => System.FilePath.mk arg)
  let paths :=
    match args with
    | [] => [defaultCorpusDir]
    | _ => argPaths
  let mut warnings : List Warning := []
  for path in paths do
    warnings := warnings ++ (← lintPath path)
  for warning in warnings do
    IO.eprintln warning.render
  if warnings.isEmpty then
    IO.println "human_checked_lint: all public non-main corpus functions have nearby human-checked markers."
  else
    IO.eprintln s!"human_checked_lint: {warnings.length} warning(s); continuing because missing human-checked comments are advisory."

end StrataJava.HumanCheckedLint

def main (args : List String) : IO Unit :=
  StrataJava.HumanCheckedLint.run args
