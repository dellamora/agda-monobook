module Base.AVL.Type where

open import Base.AVL.Balance.Type
open import Base.Pair.Type

-- Defines an AVL tree datatype.
-- - K: The type of keys stored in the tree.
-- - V: The type of values stored in the tree.
data AVL (K V : Set) : Set where
  Leaf : AVL K V
  Node : (key-value : Pair K V) → (balance : Balance) → (left : AVL K V) → (right : AVL K V) → AVL K V
