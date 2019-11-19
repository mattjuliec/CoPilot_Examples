--------------------------------------------------------------------------------
-- Copyright © 2019 National Institute of Aerospace / Galois, Inc.
--------------------------------------------------------------------------------

-- | Example showing an implementation of a resettable counter.
-- | compile the example with ghc counter.hs, run ./counter and you will see result. Change the number to interpret

{-# LANGUAGE RebindableSyntax #-}

module Main where

import Language.Copilot

-- A resettable counter
counter :: Stream Bool -> Stream Bool -> Stream Int32
counter inc reset = cnt
  where
    cnt = if reset then 0
          else if inc then z + 1
               else z
    z = [0] ++ cnt

-- Counter that resets when it reaches 256
bytecounter :: Stream Int32
bytecounter = counter true reset where
  reset = counter true false == 256

spec :: Spec
spec = trigger "counter" true [arg $ bytecounter]

main :: IO ()
main = interpret 270 spec