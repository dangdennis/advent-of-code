#!/bin/bash

YEAR=2022
AOC_BASE_URL="https://adventofcode.com/$YEAR/"

# Function to create a new Advent of Code solution for a given day
create_new_solution() {
  echo "Creating a new Advent of Code template for day $number."
  local number="$1"
  local d="day-$number"

  if [ -f "./.env" ]; then
    echo "found .env file..."
    export "$(grep -v '^#' .env | xargs)"

  fi

  # Ensure that the AOC_SESSION cookie is set
  if [ -z "$AOC_SESSION" ]; then
    echo "AOC_SESSION is not set. Please provide your Advent of Code session cookie:"
    read -r AOC_SESSION
  fi

  # Create a directory for the day
  mkdir -p inputs
  mkdir -p solutions

  # Create the Haskell solution file
  module_template="module Main where

import System.Environment (getArgs)
import Data.ByteString qualified as B

{- Types for your input and your solution

- Input    should as the type of your input parameter. AOC, typically uses arrays, matrices or complex data structures. 
- Solution should be the type of your solution. Typically is an Int, but It can be other things, like a list of numbers
         or a list of characters
-}
type Input    = B.ByteString  -- default to Bytestring, but very likely you'll need to change it
type Solution = Int

-- | parser transforms a raw bytestring (from your ./input/day-X.input) to your Input type. 
--   this is intended to use attoparsec for such a transformation. You can use Prelude's 
--   String if it fit better for the problem
parser :: B.ByteString -> Input
parser = undefined

-- | The function which calculates the solution for part one
solve1 :: Input -> Solution
solve1 = error \"Part 1 Not implemented\"

-- | The function which calculates the solution for part two
solve2 :: Input -> Solution
solve2 = error \"Part 2 Not implemented\"

main :: IO ()
main = do
  -- run this with cabal run -- day-x <part-number> <file-to-solution>
  -- example: cabal run -- day-3 2 \"./input/day-3.example\"
  -- will run part two of day three with input file ./input/day-3.example
  [part, filepath] <- getArgs
  input <- parser <$> B.readFile filepath -- use parser <$> readFile filepath if String is better
  if read @Int part == 1
    then do
      print \"solution to problem 1 is:\"
      print $ solve1 input
    else do
      print \"solution to problem 2 is:\"
      print $ solve2 input
"
  echo Creating files...

  echo "$module_template" > "./solutions/$d.hs"

  # Create an empty input file
  touch "./inputs/$d.example"

  # Download the input data from Advent of Code
  curl -o "./inputs/$d.input" -b "session=${AOC_SESSION}" "$AOC_BASE_URL"day/"$number"/input

  # Append the day to the advent-of-code.cabal file
  cabal_day="executable ${d}
  import: deps
  main-is: ${d}.hs
  hs-source-dirs:
      solutions
"
  echo "$cabal_day" >> advent-of-code.cabal

  echo "Created a new Advent of Code solution for day $number."
}

run_solution() {
  local number="$1"
  local part="$2"
  local file_name="$3"
  local d="day-$number"

  # Check if the file exists
  if [ ! -f "$file_name" ]; then
    echo "input file $file_name does not exist."
    exit 1
  fi

  # Check if the number is a positive integer
  if ! [[ "$number" =~ ^([1-9]|1\d|2[0-5])$ ]]; then
    echo "Invalid day: $number. It should be between 1 and 25"
    exit 1
  fi

  # Check if the number is a positive integer
  if ! [[ "$part" =~ ^[1-2]+$ ]]; then
    echo "Invalid part number: $part. It should be 1 or 2"
    exit 1
  fi

  echo "Running solution for a new Advent of Code template for day $number, Part $part"
  cabal run "$d" -- "$part" "$file_name"
}

# Check if the first argument is a subcommand and shift it out
if [ "$1" == "new" ] || [ "$1" == "run" ]; then
  subcommand="$1"
  shift
fi

while getopts ":d:-:f:ei:p:" opt; do
  case $opt in
    d)
      number="$OPTARG"
      ;;
    f)
      run_command=f
      run_filename="$OPTARG"
      ;;
    e)
      run_command=example
      ;;
    i)
      run_command=input
      ;;
    -)
      run_command="$OPTARG"
      ;;
    p)
      part="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Now you can check the parsed options and execute the corresponding actions.
if [ "$subcommand" == "new" ]; then
  if [ -z "$number" ]; then
    echo "Missing day for 'new' command."
    exit 1
  fi
  
  create_new_solution "$number"

elif [ "$subcommand" == "run" ]; then
  if [ -z "$number" ]; then
    echo "Missing day for 'run' command. Use option -d <day-number>"
    exit 1
  fi

  if [ -z "$part" ]; then
    echo "Missing part for 'run' command. Use option -p <part-number>"
    exit 1
  fi

  if [ -z "$run_command" ]; then
    # Default to '--input' if no filename is provided
    run_command=input
  fi

  case "$run_command" in
    example)
      run_filename="./inputs/day-$number.example"
      ;;
    input)
      run_filename="./inputs/day-$number.input"
      ;;
    f) ;;
    *)
      echo "unknown file. Use -f <file-path> for custom files"
  esac

  run_solution "$number" "$part" "$run_filename"

else
  echo "Usage: aoc-hs [new -d <day> | run -d <day> -p <part> [-f <file-name> | --example | -e | --input | -i]]

Description:
  This tool simplifies Advent of Code solutions in Haskell by creating templates and handling input files. No need to learn Cabal!

Subcommand: new

Create a new Advent of Code solution for the specified day. It creates a main module, modifies the .cabal file, and downloads the input data.

Usage: aoc-hs new -d <day>
Example: aoc-hs new -d 3
Options:
  -d <day>       Specify the day for the Advent of Code puzzle (1-25).

Subcommand: run

Run an Advent of Code solution for the specified day and part. The input data is read from a file which can be supplied via -f or you can 
use shortcuts --example and --input. Default --input

Usage: aoc-hs run -d <day> -p <part> [-f <file-name> | --example | -e | --input | -i]
Example: aoc-hs run -d 3 -p 2 --example
         aoc-hs run -d 3 -p 3 -e
         aoc-hs run -d 3 -p 2 --input
         aoc-hs run -d 3 -p 2 -i
         aoc-hs run -d 3 -p 2 -f my-input-file.txt
Options:
  -d <day>       Specify the day for the Advent of Code puzzle (1-25).
  -p <part>      Specify the part of the puzzle (1 or 2).
  -f <file-name> Specify a custom input file to use.
  --example, -e  Use the example input file (./inputs/day-<day>.example) as input.
  --input, -i    (Default) Use the puzzle input file (./inputs/day-<day>.input) as input.
"
  exit 1
fi
