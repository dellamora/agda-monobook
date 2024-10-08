module Base.AVL.fold where

open import Base.AVL.Type
open import Base.Pair.Type

-- Performs a fold operation over an AVL tree.
-- - f: The combining function.
-- - z: The initial value (for the empty tree case).
-- - tree: The AVL tree to fold over.
-- = The result of folding the tree.
fold : ∀ {K V A : Set} → (Pair K V → A → A) → A → AVL K V → A
fold f z Leaf = z
fold f z (Node value _ left right) = do
  let left-result = fold f z left
  let curr-result = f value left-result
  fold f curr-result right
