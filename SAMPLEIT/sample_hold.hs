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
    -- | Boolean signal that becomes True at time 0 and every n samples after that.
    -- samples are determined by the 'mod' x (where x is 2 in this case)
    -- To see it show up in simulink, set the sample time to 100, this will create 
    -- a sawtooth "sample and hold" function
    period4 :: Stream Bool
    period4 = (counter `mod` 2) == 0
    
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
