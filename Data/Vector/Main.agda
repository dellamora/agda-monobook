module Data.Vector.Main where

open import Data.Nat.Main

-- Defines a vector (length-indexed list) datatype.
-- - A: The type of elements in the vector.
-- - n: The length of the vector.
data Vector (A : Set) : Nat → Set where
  []   : Vector A zero
  _::_ : ∀ {n} → A → Vector A n → Vector A (succ n)

infixr 5 _::_
