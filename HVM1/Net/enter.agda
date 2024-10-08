module HVM1.Net.enter where

open import HVM1.Net.Type
open import HVM1.Port.Type
open import HVM1.Node.Type
open import HVM1.Node.port-get
open import Base.Maybe.Type
open import Base.Maybe.Monad.bind
open import Base.Maybe.run
import Base.Map.Type as M
import Base.Map.get as M

-- Enters a port in the Net, returning the connected port.
-- - net: The Net to traverse.
-- - port: The Port to enter from.
-- = The connected Port, or the original Port if not found.
enter : Net → Port → Port
enter (MkNet net) port = run port (do
  node ← M.get net (Port.addr port)
  Some (port-get node (Port.slot port)))
