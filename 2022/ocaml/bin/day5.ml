let part1 lines = 0
let part2 lines = 0

let () =
  let lines = Lib.extract_lines "bin/day5.txt" in
  print_endline "day 4";
  print_string "part 1: ";
  part1 lines |> print_int;
  print_newline ();
  print_string "part 2: ";
  part2 lines |> print_int;
  print_newline ();
  ()
