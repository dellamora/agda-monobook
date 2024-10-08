module Base.Map.Test.get where

open import Base.Map.Type
open import Base.Map.get
open import Base.Map.empty
open import Base.Map.set
open import Base.Bits.Type
open import Base.Nat.Type
open import Base.Maybe.Type
open import Base.Equal.Type

test-get-empty : get empty E === None
test-get-empty = refl

test-get-root : get (set empty E 1) E === Some 1
test-get-root = refl

test-get-left : get (set empty (O E) 1) (O E) === Some 1
test-get-left = refl

test-get-right : get (set empty (I E) 1) (I E) === Some 1
test-get-right = refl

test-get-non-existing : get (set empty (O E) 1) (I E) === None
test-get-non-existing = refl

test-get-deeper-existing : 
  let m = set (set empty (O (I E)) 1) (I (O E)) 2
  in get m (O (I E)) === Some 1
test-get-deeper-existing = refl

test-get-deeper-non-existing : 
  let m = set (set empty (O (I E)) 1) (I (O E)) 2
  in get m (O (O E)) === None
test-get-deeper-non-existing = refl

test-get-overwrite : 
  let m = set (set empty E 1) E 2
  in get m E === Some 2
test-get-overwrite = refl

