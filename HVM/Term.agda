module HVM.Term where

open import Data.Nat.Type

data Term : Set where
  Var : Nat → Term
  App : Term → Term → Term
  Lam : Term → Term
