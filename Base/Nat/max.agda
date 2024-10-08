module Base.Nat.max where

open import Base.Nat.Type
open import Base.Bool.if
open import Base.Nat.Ord
open import Base.Ord.Trait

-- Returns the maximum of two natural numbers.
-- - x: The first natural number.
-- - y: The second natural number.
-- = The larger of x and y.
max : Nat → Nat → Nat
max x y = if (_>=_ {{OrdNat}} x y) then x else y
