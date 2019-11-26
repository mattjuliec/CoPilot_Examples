module Main where

  import Language.Copilot
  import Copilot.Compile.C99
  
  import Prelude hiding ((>), (<), div,(++))
  
  -- External value
  val :: Stream Double
  val = extern "value" Nothing

  ext :: Stream (Array 2 Double)
  ext = [[array [1,1], array [(extern "e0" interp1),(extern "e1" interp2)]] ++ ext 
    where interp1 = Just [2,4..]
  
  cval :: Stream Double
  cval = val
  
  spec = do
    -- Triggers that fire when the val is too low or too high,
    -- pass the current cval as an argument.
    trigger "too_high"  (cval > 200.0) [arg cval]
    trigger "too_low" (cval < 0.0) [arg cval]
  
  -- Compile the spec
  main = reify spec >>= compile "PID"


    
    