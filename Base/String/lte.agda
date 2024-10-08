module Base.String.lte where

open import Base.String.Type
open import Base.String.to-list
open import Base.Bool.Type
open import Base.Char.Type
import Base.List.lte as List
open import Base.Char.Ord

lte : String → String → Bool
lte s1 s2 = List.lte {{OrdChar}} (to-list s1) (to-list s2)
