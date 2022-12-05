module CharSet = Set.Make (Char)

let char_to_priority dupe =
  let is_upper = Char.uppercase_ascii dupe == dupe in
  if is_upper then Char.code dupe - 64 + 26 else Char.code dupe - 64 - 32

let part1 rucksacks =
  let sum_priorities_per_rucksack =
    List.map
      (fun rucksack ->
        let len = String.length rucksack in
        let half_len = len / 2 in
        let first_compartment = String.sub rucksack 0 half_len in
        let second_compartment = String.sub rucksack half_len half_len in
        let set1 = CharSet.empty in
        let set2 = CharSet.empty in
        let set1 = String.fold_right CharSet.add first_compartment set1 in
        let set2 = String.fold_right CharSet.add second_compartment set2 in
        let duplicates = CharSet.inter set1 set2 in
        let priorities =
          CharSet.to_seq duplicates |> Seq.map char_to_priority
        in
        let sum_p = Seq.fold_left (fun p sum -> p + sum) 0 priorities in
        sum_p)
      rucksacks
  in
  let sum =
    List.fold_left (fun sum curr -> sum + curr) 0 sum_priorities_per_rucksack
  in
  sum

let part2 rucksacks =
  let sum_priorities_per_rucksack =
    List.map
      (fun rucksack ->
        let len = String.length rucksack in
        let half_len = len / 2 in
        let first_compartment = String.sub rucksack 0 half_len in
        let second_compartment = String.sub rucksack half_len half_len in
        let set1 = CharSet.empty in
        let set2 = CharSet.empty in
        let set1 = String.fold_right CharSet.add first_compartment set1 in
        let set2 = String.fold_right CharSet.add second_compartment set2 in
        let duplicates = CharSet.inter set1 set2 in
        let priorities =
          CharSet.to_seq duplicates |> Seq.map char_to_priority
        in
        let sum_p = Seq.fold_left (fun p sum -> p + sum) 0 priorities in
        sum_p)
      rucksacks
  in
  let sum =
    List.fold_left (fun sum curr -> sum + curr) 0 sum_priorities_per_rucksack
  in
  sum

let () =
  let lines = Lib.extract_lines "bin/day3.txt" in
  print_endline "day 3";
  print_string "part 1: ";
  part1 lines |> print_int;
  print_newline ();
  print_string "part 2: ";
  part2 lines |> print_int;
  print_newline ();
  ()
