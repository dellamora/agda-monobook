module HVM1.Node.Type where

open import Data.Bits.Type
open import Data.Nat.Type
open import HVM1.Port.Type

-- Represents a node in the HVM1 system
data Node : Set where
  Con : (tag : Bits) → (p0 p1 p2 : Port) → Node
  Dup : (tag : Bits) → (p0 p1 p2 : Port) → Node
  Era : Node
