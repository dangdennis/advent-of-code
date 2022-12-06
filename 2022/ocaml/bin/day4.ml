let to_pairs l =
  let to_pair s =
    match String.split_on_char '-' s with
    | [] -> failwith "Not pairs"
    | _ :: [] -> failwith "Not pairs"
    | fst :: snd :: _ -> (int_of_string fst, int_of_string snd)
  in
  let sections = l |> String.split_on_char ',' in
  let left, right =
    match sections with
    | [] -> failwith "Missing both sections"
    | _ :: [] -> failwith "Missing a section"
    | fst :: snd :: _ -> (fst |> to_pair, snd |> to_pair)
  in
  (left, right)

let part1 lines =
  let section_pairs = lines |> List.map to_pairs in

  let num_contained_pairs =
    section_pairs
    |> List.fold_left
         (fun num section_pair ->
           let is_contained =
             match section_pair with
             | (lower1, upper1), (lower2, upper2)
               when (lower1 <= lower2 && upper1 >= upper2)
                    || (lower2 <= lower1 && upper2 >= upper1) ->
                 1
             | _ -> 0
           in
           num + is_contained)
         0
  in

  num_contained_pairs

let part2 lines =
  let section_pairs = lines |> List.map to_pairs in
  let num_overlapping_pairs =
    section_pairs
    |> List.fold_left
         (fun num section_pair ->
           let is_overlapping =
             match section_pair with
             | (lower1, upper1), (lower2, upper2)
               when min upper2 upper1 - max lower2 lower1 + 1 > 0 ->
                 1
             | _ -> 0
           in
           num + is_overlapping)
         0
  in

  num_overlapping_pairs

let () =
  let lines = Lib.extract_lines "bin/day4.txt" in
  print_endline "day 4";
  print_string "part 1: ";
  part1 lines |> print_int;
  print_newline ();
  print_string "part 2: ";
  part2 lines |> print_int;
  print_newline ();
  ()
