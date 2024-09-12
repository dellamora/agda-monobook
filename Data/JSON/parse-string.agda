module Data.JSON.parse-string where

open import Data.JSON.Type
open import Data.Parser.Type
open import Data.Parser.bind
open import Data.Parser.pure
open import Data.Parser.skip-spaces
open import Data.Parser.consume
open import Data.Parser.fail
open import Data.Parser.parse-char
open import Data.Parser.alternative
open import Data.Char.Type
open import Data.Char.eq
open import Data.Char.from-nat
open import Data.Char.hex-to-nat
open import Data.String.from-char
open import Data.String.Type
open import Data.String.from-list
open import Data.List.Type
open import Data.Bool.Type
open import Data.Bool.if
open import Data.Bool.or
open import Data.Function.case
open import Data.Nat.Type
open import Data.Nat.mul
open import Data.Nat.add
open import Data.Maybe.Type

-- Parse a single hexadecimal digit
parse-hex-digit : Parser Nat
parse-hex-digit = do
  c ← parse-char
  case hex-to-nat c of λ where
    (Some n) → pure n
    None     → fail "Invalid hexadecimal digit"

-- Parse four hexadecimal digits
parse-four-hex-digits : Parser Nat
parse-four-hex-digits = do
  d1 ← parse-hex-digit
  d2 ← parse-hex-digit
  d3 ← parse-hex-digit
  d4 ← parse-hex-digit
  pure (((d1 * 4096) + (d2 * 256)) + ((d3 * 16) + d4))

-- Parses an escape sequence
parse-escape : Parser Char
parse-escape = do
  consume "\\"
  (parse-char >>= λ where
    '"'  → pure '"'
    '\\' → pure '\\'
    '/'  → pure '/'
    'b'  → pure '\b'
    'f'  → pure '\f'
    'n'  → pure '\n'
    'r'  → pure '\r'
    't'  → pure '\t'
    'u'  → do
      code ← parse-four-hex-digits
      pure (from-nat code)
    _    → fail "Invalid escape sequence")

-- Parses a single character in a JSON string
parse-string-char : Parser Char
parse-string-char =
  parse-escape <|> do
    c ← parse-char
    if (c == '"') || (c == '\\')
      then fail "Unexpected '\"' or '\\'"
      else pure c

-- Parses the contents of a JSON string
parse-string-contents : Parser (List Char)
parse-string-contents =
  (parse-string-char >>= λ c →
   parse-string-contents >>= λ cs →
   pure (c :: cs))
  <|> pure []

-- Parses a JSON string and returns the String value
parse-string-value : Parser String
parse-string-value = do
  skip-spaces
  consume "\""
  chars ← parse-string-contents
  consume "\""
  pure (from-list chars)

-- Parses a JSON string and returns a JSON value
parse-string : Parser JSON
parse-string = do
  str ← parse-string-value
  pure (JString str)
