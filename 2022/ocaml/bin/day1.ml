let take n l =
  let rec sub_list n acc l =
    match l with
    | [] -> acc
    | hd :: tl -> if n = 0 then acc else sub_list (n - 1) (hd :: acc) tl
  in
  sub_list n [] l

let part1 lines : int =
  let rec find max_cal sum_cal lines =
    match lines with
    | [] -> max_cal
    | l :: ls -> (
        match int_of_string_opt l with
        | None -> find max_cal 0 ls
        | Some cal ->
            let sum = sum_cal + cal in
            let cal = Int.max max_cal sum in
            find cal sum ls)
  in
  find 0 0 lines

let part2 lines : int =
  let rec find sum cals lines =
    match lines with
    | [] -> cals
    | l :: ls -> (
        match int_of_string_opt l with
        | None -> find 0 (sum :: cals) ls
        | Some cal ->
            let sum = sum + cal in
            find sum cals ls)
  in
  let cals = find 0 [] lines |> List.sort (fun a b -> b - a) in
  List.fold_left (fun cal acc -> cal + acc) 0 (take 3 cals)

let run () =
  let lines = Lib.extract_lines "bin/day1.txt" in
  print_newline ();
  print_endline "day 1";
  part1 lines |> print_int;
  print_newline ();
  part2 lines |> print_int;
  print_newline ();
  ()

let () = run ()
