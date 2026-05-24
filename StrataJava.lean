import Strata
import StrataJava.ArithmeticFacts

namespace StrataJava

/-- Canonical Strata Core sketch for the full Java corpus. -/
def coreSketchPath : String :=
  "lean/strata/boogie/CoreSketch.core.st"

/-- Focused Core sketch for the ArithmeticFacts pipeline test. -/
def arithmeticFactsSketchPath : String :=
  "lean/strata/boogie/arithmetic-facts/ArithmeticFacts.core.st"

end StrataJava
