module Base.String.gte where

open import Base.String.Type
open import Base.String.to-list
open import Base.Bool.Type
open import Base.Char.Type
import Base.List.gte as List
open import Base.Char.Ord

gte : String → String → Bool
gte s1 s2 = List.gte {{OrdChar}} (to-list s1) (to-list s2)
