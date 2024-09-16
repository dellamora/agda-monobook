module Data.U64.from-bits where

open import Data.U64.Type
open import Data.Bits.Type
open import Data.Nat.Type
open import Data.Maybe.Type
open import Data.Nat.double 

-- Converts a bit representation to a Maybe U64.
-- - x: The bit representation to convert.
-- = The U64 representation of x, or nothing if conversion fails.
from-bits : Bits → Maybe U64
from-bits b = helper b Zero
    where
        helper : Bits → Nat → Maybe U64
        helper E acc = Some (primWord64FromNat acc)
        helper (O bs) acc = helper bs (double acc)
        helper (I bs) acc = helper bs (Succ (double acc))
        
