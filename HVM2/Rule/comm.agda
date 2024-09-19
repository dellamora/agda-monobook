module HVM2.Rule.comm where

open import Base.Unit.Type
open import HVM2.Run.Type
open import HVM2.Run.Monad.bind
open import HVM2.Run.fresh
open import HVM2.Run.link
open import HVM2.Run.Monad.pure
open import HVM2.Term.Type

-- Commutation interaction
comm : Term → Term → Term → Term → Run Unit
comm a1 a2 b1 b2 = do
  v0 ← fresh
  v1 ← fresh
  v2 ← fresh
  v3 ← fresh
  let n0 = Con (Var v0) (Var v1)
  let n1 = Con (Var v2) (Var v3)
  let n2 = Dup (Var v0) (Var v2)
  let n3 = Dup (Var v1) (Var v3)
  link a1 n0
  link a2 n1
  link b1 n2
  link b2 n3
  pure unit
