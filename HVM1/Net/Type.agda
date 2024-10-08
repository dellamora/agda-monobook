module HVM1.Net.Type where

import Base.Map.Type as M
open import HVM1.Node.Type

-- Represents a net of nodes in the HVM1 system
record Net : Set where
  constructor MkNet
  field
    net : M.Map Node
