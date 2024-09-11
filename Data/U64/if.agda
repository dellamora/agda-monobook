module Data.U64.if where 


open import Data.U64.Type 
open import Data.Bool.Type 
open import Data.Nat.Type

if : ∀ {a} {A : Set a} → U64 → A → A → A
if n t f = go (primWord64ToNat n) t f
  where 
   go :  ∀ {a} {A : Set a} → Nat → A → A → A 
   go Zero t f = f
   go (Succ _) t f = t
   


