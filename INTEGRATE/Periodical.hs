import Language.Copilot
import Copilot.Compile.C99

import Prelude hiding ((>), (<), div, mod, (==), (++), drop)

-- Sample some external data
externalVar :: Stream Double
externalVar = extern "value" Nothing

-- Piece-wise sampling of externVar, every n samples.
periodical :: Stream Double
periodical = ifThenElse period4 externalVar ([0] ++ periodical)
  where
    -- | Boolean signal that becomes True at time 0 and every 4 samples after that.
    period4 :: Stream Bool
    period4 = (counter `mod` 3) == 0
    
    -- | Time starting from 0.
    counter :: Stream Int32
    counter = [0] ++ counter + 1
    
spec = do
  -- Triggers that always fires but does a sample and hold on previous values based 
  -- the length of a sampling period
  trigger "heaton"  (true) [arg periodical]

-- Compile the spec
-- main = interpret 10 spec
main = reify spec >>= compile "monitor"
