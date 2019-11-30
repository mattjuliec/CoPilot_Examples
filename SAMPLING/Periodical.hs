--------------------------------------------------------------------------------
-- Copyright © 2019 National Institute of Aerospace / Galois, Inc.
--------------------------------------------------------------------------------

-- | Example showing how to sample data.
-- | compile the example with ghc Periodical.hs, run ./Periodical and you will see result. Change the number to interpret

import Language.Copilot
import Copilot.Compile.C99

import Prelude hiding ((>), (<), div, mod, (==), (++))

-- | External stream linked to the extern some_var of type int.
--
-- Sample data is added to be able to simulate 11 samples.
externalVar :: Stream Int32
externalVar = extern "some_var" (Just [5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

-- | Piece-wise sampling of externalVar, every 4 samples, with a one
-- step shift making the first sample 99.
periodical :: Stream Int32
periodical = [99] ++ periodical'
  where
    -- | Piece-wise sampling of externVar, every 4 samples.
    periodical' :: Stream Int32 
    periodical' = ifThenElse period4 externalVar ([0] ++ periodical')
    
    -- | Boolean signal that becomes True at time 0 and every 4 samples
    -- after that.
    period4 :: Stream Bool
    period4 = (counter `mod` 4) == 0
    
    -- | Time starting from 0.
    counter :: Stream Int32
    counter = [0] ++ counter + 1
    
spec = do
  -- Triggers that fire when the ctemp is too low or too high,
  -- pass the current ctemp as an argument.
  trigger "heaton"  (true) [arg periodical]

-- Compile the spec
main = interpret 10 spec
