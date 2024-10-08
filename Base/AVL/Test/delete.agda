module Base.AVL.Test.delete where

open import Base.AVL.Type
open import Base.AVL.delete
open import Base.AVL.insert
open import Base.AVL.empty
open import Base.AVL.to-list
open import Base.AVL.Test.is-balanced
open import Base.Equal.Type
open import Base.Bool.Type
open import Base.Bool.and
open import Base.Nat.Type
open import Base.Nat.eq
open import Base.Nat.Ord
open import Base.List.Type
open import Base.List.eq
open import Base.Unit.Type
open import Base.Unit.eq
open import Base.Pair.Type
open import Base.Pair.eq

-- Test 1: Deleting from an empty tree
test-delete-empty : delete 5 (empty {V = Unit}) === empty
test-delete-empty = refl

-- Test 2: Deleting a non-existent element
test-delete-non-existent : delete 5 (insert (3 , unit) empty) === insert (3 , unit) empty
test-delete-non-existent = refl

-- Test 3: Deleting the root of a single-element tree
test-delete-root-single : delete 3 (insert (3 , unit) empty) === empty
test-delete-root-single = refl

-- Test 4: Deleting from a balanced tree
test-delete-balanced : 
  let tree = insert (2 , unit) (insert (1 , unit) (insert (3 , unit) empty))
      result = delete 2 tree
  in (to-list result == to-list (insert (3 , unit) (insert (1 , unit) empty))) && is-balanced result === True
test-delete-balanced = refl

-- Test 5: Deleting causing a left rotation
test-delete-left-rotation :
  let tree = insert (4 , unit) (insert (3 , unit) (insert (2 , unit) (insert (1 , unit) empty)))
      result = delete 1 tree
  in is-balanced result === True
test-delete-left-rotation = refl

-- Test 6: Deleting causing a right rotation
test-delete-right-rotation :
  let tree = insert (1 , unit) (insert (2 , unit) (insert (3 , unit) (insert (4 , unit) empty)))
      result = delete 4 tree
  in is-balanced result === True
test-delete-right-rotation = refl

-- Test 7: Deleting from a larger tree
test-delete-larger-tree :
  let tree = insert (5 , unit) (insert (3 , unit) (insert (7 , unit) (insert (2 , unit) (insert (4 , unit) (insert (6 , unit) (insert (8 , unit) empty))))))
      result = delete 3 tree
  in is-balanced result && (to-list result == (2 , unit) :: (4 , unit) :: (5 , unit) :: (6 , unit) :: (7 , unit) :: (8 , unit) :: []) === True
test-delete-larger-tree = refl

-- Test 8: Multiple deletions
test-multiple-deletions :
  let tree = insert (5 , unit) (insert (3 , unit) (insert (7 , unit) (insert (2 , unit) (insert (4 , unit) (insert (6 , unit) (insert (8 , unit) empty))))))
      result = delete 4 (delete 7 (delete 2 tree))
  in is-balanced result && (to-list result == (3 , unit) :: (5 , unit) :: (6 , unit) :: (8 , unit) :: []) === True
test-multiple-deletions = refl

-- Test 9: Deleting all elements
test-delete-all :
  let tree = insert (3 , unit) (insert (2 , unit) (insert (1 , unit) empty))
      result = delete 2 (delete 3 (delete 1 tree))
  in result === empty
test-delete-all = refl

-- Test 10: Deleting and re-inserting
test-delete-reinsert :
  let tree = insert (3 , unit) (insert (2 , unit) (insert (1 , unit) empty))
      intermediate = delete 2 tree
      result = insert (2 , unit) intermediate
  in (to-list result == to-list tree) && is-balanced result === True
test-delete-reinsert = refl
