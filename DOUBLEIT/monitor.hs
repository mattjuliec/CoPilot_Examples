--------------------------------------------------------------------------------
-- Copyright 2019 Galois, Inc.
--------------------------------------------------------------------------------

-- This is a simple example illustrating how to instrument Matlab / Simulink with 
-- a copilot generated monitor.
-- The "doubleIT" c and header files are generated using copilot based on the example
-- From https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html
-- To compile the Copilot monitor and generate c code 
-- > ghc monitor.hs
-- > ./monitor
-- > c99 doubleIT.c monitor.c -o doubleIT


module Main where

    import Language.Copilot
    import Copilot.Compile.C99
    
    import Prelude hiding ((>), (<), div)
    
    -- External value
    val :: Stream Double
    val = extern "value" Nothing
    
    cval :: Stream Double
    cval = val
    
    spec = do
      -- Triggers that fire when the val is too low or too high,
      -- pass the current cval as an argument.
      trigger "too_high"  (cval > 200.0) [arg cval]
      trigger "too_low" (cval < 0.0) [arg cval]
    
    -- Compile the spec
    main = reify spec >>= compile "monitor"