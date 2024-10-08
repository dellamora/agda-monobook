module Base.OrdMap.values where

open import Base.OrdMap.Type
open import Base.List.Type
import Base.AVL.values as AVL

-- Extracts all values from an OrdMap.
-- - map: The OrdMap to extract values from.
-- = A list containing all values from the map.
values : ∀ {K V : Set} → OrdMap K V → List V
values = AVL.values
