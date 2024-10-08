module Base.Map.swap where

open import Base.Map.Type
open import Base.Bits.Type
open import Base.Maybe.Type
open import Base.Tree.Type
open import Base.Pair.Type

-- Swaps a value in the Map for a new value, returning the old value if it existed.
-- - m: The Map to swap in.
-- - k: The Bits key to swap.
-- - v: The new value to insert.
-- = A pair containing the new Map and the old value associated with the key (wrapped in Maybe).
swap : ∀ {A : Set} → Map A → Bits → A → Pair (Map A) (Maybe A)
swap (Node val lft rgt) E     v = (Node (Some v) lft rgt) , val
swap (Node val lft rgt) (O k) v = let (new-lft , old-val) = swap lft k v in (Node val new-lft rgt) , old-val
swap (Node val lft rgt) (I k) v = let (new-rgt , old-val) = swap rgt k v in (Node val lft new-rgt) , old-val
swap Leaf               E     v = (Node (Some v) Leaf Leaf) , None
swap Leaf               (O k) v = let (new-lft , old-val) = swap Leaf k v in (Node None new-lft Leaf) , old-val
swap Leaf               (I k) v = let (new-rgt , old-val) = swap Leaf k v in (Node None Leaf new-rgt) , old-val
