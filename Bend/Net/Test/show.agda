module Bend.Net.Test.show where

open import Base.String.Type
open import Base.String.eq
open import Base.Equal.Type
open import Base.Map.Type
open import Base.Map.empty
open import Base.Map.set
open import Base.Nat.Type
open import Base.Bits.from-nat
open import Bend.Net.Type
open import Bend.Net.Node.Type
open import Bend.Net.Port.Type
open import Bend.Net.NodeKind.Type
open import Bend.Net.show

test-show-empty-net : show (MkNet empty 0 "EmptyNet") === "@EmptyNet =\n"
test-show-empty-net = refl

test-show-single-node-net :
  let node = MkNode (MkPort 0 0) (MkPort 0 1) (MkPort 0 2) Era
      net = MkNet (set empty (from-nat 0) node) 1 "SingleNodeNet"
      expected-output = "@SingleNodeNet =\n0: [Era (0, 0) (0, 1) (0, 2)]\n"
  in show net === expected-output
test-show-single-node-net = refl

test-show-multi-node-net : 
  let node1 = MkNode (MkPort 0 0) (MkPort 0 1) (MkPort 0 2) Era
      node2 = MkNode (MkPort 1 0) (MkPort 1 1) (MkPort 1 2) Dup
      net = MkNet (set (set empty (from-nat 0) node1) (from-nat 1) node2) 2 "MultiNodeNet"
      expected-output = "@MultiNodeNet =\n0: [Era (0, 0) (0, 1) (0, 2)]\n1: [Dup (1, 0) (1, 1) (1, 2)]\n"
  in show net === expected-output
test-show-multi-node-net = refl

test-show-num-ref-nodes :
  let node1 = MkNode (MkPort 0 0) (MkPort 0 1) (MkPort 0 2) (Num (from-nat 42))
      node2 = MkNode (MkPort 1 0) (MkPort 1 1) (MkPort 1 2) (Ref "example")
      net = MkNet (set (set empty (from-nat 0) node1) (from-nat 1) node2) 2 "NumRefNet"
      expected-output = "@NumRefNet =\n0: [Num(42) (0, 0) (0, 1) (0, 2)]\n1: [Ref(\"example\") (1, 0) (1, 1) (1, 2)]\n"
  in show net === expected-output
test-show-num-ref-nodes = refl
