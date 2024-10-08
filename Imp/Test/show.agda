module Imp.Test.show where

import Imp.Expr.Type as Expr'
open import Imp.Stmt.Type
open import Imp.Notation
open import Imp.Stmt.show as Stmt
open import Base.Nat.Type
open import Base.U64.Type
open import Base.List.Type
open import Base.Equal.Type

private
  open module Expr = Expr' Stmt
  from-nat : Nat → Expr
  from-nat n = Num (primWord64FromNat n)

fib : Expr → Stmt
fib n = do
  local ("a" :: "b" :: [])

  "a" := from-nat 0
  "b" := from-nat 1
  "n" := n

  while ↑"n" > from-nat 0 go do
    "t" := ↑"b"
    "b" := ↑"a" + ↑"b"
    "a" := ↑"t"
    "n" -= from-nat 1

  return ↑"a"

example : Stmt
example = do
  local ("fib1" :: "fib2" :: [])

  "fib1" := Call (fib (from-nat 1))
  "fib2" := Call (fib (from-nat 2))

expected-string = "local fib1, fib2
fib1 = ({
  local a, b
  a = 0
  b = 1
  n = 1
  while (n > 0) {
    t = b
    b = a + b
    a = t
    n = n - 1
  }
  return a
})
fib2 = ({
  local a, b
  a = 0
  b = 1
  n = 2
  while (n > 0) {
    t = b
    b = a + b
    a = t
    n = n - 1
  }
  return a
})"

test-example : (Stmt.show example) === expected-string
test-example = refl
