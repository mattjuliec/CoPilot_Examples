
module Main where

import Copilot.Compile.C99
import Copilot.Language
import Copilot.Library.MTL hiding (always, eventually, trigger)
import Language.Copilot (Stream, always, eventually, reify, (++))
import Prelude hiding ((++))

-- External signal. True if a message has just been sent.
messageSent :: Stream Bool
messageSent = extern "messageSent" Nothing
-- External signal. True if a response has just been received.

responseReceived :: Stream Bool
responseReceived = extern "responseReceived" Nothing
-- True if no response to a message is received in the two samples
-- following that message.
messagesObtainResponsesPT :: Stream Bool
messagesObtainResponsesPT =
    alwaysBeen 0 0 (responseReceived==>eventuallyPrev 0 2 messageSent)
    
spec :: Spec
spec = do
    trigger "errors" messagesObtainResponsesPT []
main :: IO()
main = reify spec >>= compile "test"