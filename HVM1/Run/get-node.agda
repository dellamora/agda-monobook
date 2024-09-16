module HVM1.Run.get-node where

import Data.Map.Type as M
import Data.Map.get as M
open import Data.Bits.Type
open import Data.Maybe.Type
open import HVM1.Net.Type
open import HVM1.Node.Type
open import HVM1.Run.State.Type
open import HVM1.Run.Type
open import HVM1.Run.bind
open import HVM1.Run.pure
open import HVM1.Run.get-state

get-node : Bits → Run (Maybe Node)
get-node addr = do
  state ← get-state
  pure (M.get (Net.net (State.net state)) addr)
