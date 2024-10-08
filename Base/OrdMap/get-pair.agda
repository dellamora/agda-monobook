module Base.OrdMap.get-pair where

open import Base.OrdMap.Type
open import Base.Maybe.Type
open import Base.Pair.Type
open import Base.Ord.Trait
import Base.AVL.get-pair as AVL

-- Retrieves a key-value pair from the OrdMap based on the given key.
-- - K: The type of keys in the OrdMap.
-- - V: The type of values in the OrdMap.
-- - Ord K: An instance of the Ord typeclass for the key type.
-- - key: The key to search for.
-- - map: The OrdMap to search in.
-- = Maybe (Pair K V), where:
--   - Some (key, value) if the key is found with its associated value
--   - None if the key is not found in the map
get-pair : ∀ {K V : Set} → {{_ : Ord K}} → K → OrdMap K V → Maybe (Pair K V)
get-pair = AVL.get-pair
