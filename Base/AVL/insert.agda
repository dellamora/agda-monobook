module Base.AVL.insert where

open import Base.AVL.Type
open import Base.AVL.empty
open import Base.AVL.Balance.Type
open import Base.AVL.Balance.rotate-left
open import Base.AVL.Balance.rotate-right
open import Base.Ord.Trait
open import Base.Bool.Type
open import Base.Pair.Type
open import Base.Pair.get-fst
-- We compare Pairs only by their first elements
open import Base.Pair.ord.fst
open import Base.Ordering.Type
open import Base.Function.case

-- Inserts a value into an AVL tree, maintaining balance.
-- - v: The pair key-value to insert.
-- - t: The AVL tree to insert into.
-- = A new AVL tree with the value inserted and balance maintained.
insert : ∀ {K V : Set} → {{_ : Ord K}} → Pair K V → AVL K V → AVL K V
insert v t = get-fst (insert' v t) where
  -- returns True if the height increased
  insert' : ∀ {K V : Set} → {{_ : Ord K}} → Pair K V → AVL K V → Pair (AVL K V) Bool
  insert' v Leaf = Node v zero empty empty , True
  insert' v (Node curr balance left right) with compare v curr
  ... | EQ = Node curr balance left right , False
  ... | LT =
    let (other , is-higher) = insert' v left in
    case (is-higher , balance) of λ where
      (False , _   ) → Node curr balance other right , False
      (True  , +one) → Node curr zero    other right , False
      (True  , zero) → Node curr -one    other right , True
      (True  , -one) → rotate-right (Node curr -one other right)
  ... | GT =
    let (other , is-higher) = insert' v right in
    case (is-higher , balance) of λ where
      (False , _   ) → Node curr balance left other , False
      (True  , -one) → Node curr zero    left other , False
      (True  , zero) → Node curr +one    left other , True
      (True  , +one) → rotate-left (Node curr +one left other)

-- Infix notation for inserting an element into an AVL tree.
-- - x: The value to insert.
-- - t: The AVL tree to insert into.
-- = A new AVL tree with the value inserted and balance maintained.
_::>_ : ∀ {K V : Set} → {{_ : Ord K}} → Pair K V → AVL K V → AVL K V
_::>_ = insert

infixr 5 _::>_
