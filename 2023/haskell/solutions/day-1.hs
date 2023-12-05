module Main where

import Control.Monad.Cont (MonadIO (liftIO))
import Data.Text qualified as T
import Data.Text.IO qualified as TIO
import System.Environment (getArgs)

{- Types for your input and your solution

- Input    should as the type of your input parameter. AOC, typically uses arrays, matrices or complex data structures.
- Solution should be the type of your solution. Typically is an Int, but It can be other things, like a list of numbers
         or a list of characters
-}
type Input = [T.Text] -- default to Bytestring, but very likely you'll need to change it

type Solution = IO ()

-- | parser transforms a raw bytestring (from your ./input/day-X.input) to your Input type.
--   this is intended to use attoparsec for such a transformation. You can use Prelude's
--   String if it fit better for the problem
parser :: T.Text -> Input
parser = T.split (== '\n')

-- | The function which calculates the solution for part one
solve1 :: Input -> Solution
solve1 input = do
  input <- liftIO $ print input
  return ()

-- error "Part 1 Not implemented"

-- | The function which calculates the solution for part two
solve2 :: Input -> Solution
solve2 = error "Part 2 Not implemented"

main :: IO ()
main = do
  -- run this with cabal run -- day-x <part-number> <file-to-solution>
  -- example: cabal run -- day-3 2 "./input/day-3.example"
  -- will run part two of day three with input file ./input/day-3.example
  [part, filepath] <- getArgs
  input <- parser <$> TIO.readFile filepath -- use parser <$> readFile filepath if String is better
  if read @Int part == 1
    then do
      print "solution to problem 1 is:"
      ok <- solve1 input
      print ok
    else do
      print "solution to problem 2 is:"
      ok <- solve2 input
      print ok
