import Language.Copilot
import Copilot.Compile.C99

import Prelude hiding ((>), (<), div, mod, (==), (++), drop)

-- Sample some external data
externalVar :: Stream Double
externalVar = extern "value" Nothing
 
-- discrete integration of a value - dependant on external sampling period
integrate :: Stream Double
integrate = [0] ++ (integrate + externalVar)
    
spec = do
  -- Triggers that always fires but does a sample and hold on previous values based 
  -- the length of a sampling period
  trigger "heaton"  (true) [arg integrate]

-- Compile the spec
-- main = interpret 10 spec
main = reify spec >>= compile "monitor"
