module Base.Map.Test.set where

open import Base.Map.Type
open import Base.Map.set
open import Base.Map.get
open import Base.Bits.Type
open import Base.Maybe.Type
open import Base.Nat.Type
open import Base.Bool.Type
open import Base.Equal.Type

test-set-empty-root : get (set Leaf E 1) E === Some 1
test-set-empty-root = refl

test-set-empty-deep : get (set Leaf (O (I E)) 2) (O (I E)) === Some 2
test-set-empty-deep = refl

test-set-multiple-preserve : get (set (set (set Leaf E 1) (I E) 2) (O E) 3) (I E) === Some 2
test-set-multiple-preserve = refl

test-set-overwrite-root : get (set (set Leaf E 1) E 4) E === Some 4
test-set-overwrite-root = refl

test-set-preserve-root : get (set (set Leaf E 1) (I E) 2) E === Some 1
test-set-preserve-root = refl

test-set-get-nonexistent : get (set Leaf E 1) (I E) === None
test-set-get-nonexistent = refl
