type shape = Rock | Paper | Scissors
type round_state = Win | Lose | Draw

let to_score round_state my_hand =
  let hand_score h = match h with Rock -> 1 | Paper -> 2 | Scissors -> 3 in
  let round_score r = match r with Win -> 6 | Lose -> 0 | Draw -> 3 in
  hand_score my_hand + round_score round_state

let their_code_to_shape s =
  match s with
  | "A" -> Rock
  | "B" -> Paper
  | "C" -> Scissors
  | _ -> failwith "Unexpected value"

let part1 lines =
  let determine_round_state their_hand my_hand =
    match (their_hand, my_hand) with
    | Rock, Rock | Scissors, Scissors | Paper, Paper -> Draw
    | Rock, Scissors | Scissors, Paper | Paper, Rock -> Lose
    | Rock, Paper | Paper, Scissors | Scissors, Rock -> Win
  in

  let my_code_to_shape s =
    match s with
    | "X" -> Rock
    | "Y" -> Paper
    | "Z" -> Scissors
    | _ -> failwith "Unexpected value"
  in

  let round_scores =
    List.map
      (fun s ->
        match String.split_on_char ' ' s with
        | [] -> failwith "No hands played"
        | _ :: [] -> failwith "Only one hand played"
        | theirs :: mine :: _ ->
            let their_hand = theirs |> their_code_to_shape in
            let my_hand = mine |> my_code_to_shape in
            let round_state = determine_round_state their_hand my_hand in
            to_score round_state my_hand)
      lines
  in

  List.fold_left (fun sum score -> score + sum) 0 round_scores

let part2 lines =
  let round_code_to_state c =
    match c with
    | "X" -> Lose
    | "Y" -> Draw
    | "Z" -> Win
    | _ -> failwith "Invalid round code"
  in

  let determine_my_hand theirs round_state =
    match (theirs, round_state) with
    | Rock, Win | Paper, Draw | Scissors, Lose -> Paper
    | Rock, Lose | Paper, Win | Scissors, Draw -> Scissors
    | Rock, Draw | Paper, Lose | Scissors, Win -> Rock
  in

  let round_scores =
    List.map
      (fun s ->
        match String.split_on_char ' ' s with
        | [] -> failwith "No hands played"
        | _ :: [] -> failwith "Only one hand played"
        | theirs :: round_code :: _ ->
            let their_hand = theirs |> their_code_to_shape in
            let round_state = round_code |> round_code_to_state in
            let my_hand = determine_my_hand their_hand round_state in
            to_score round_state my_hand)
      lines
  in

  List.fold_left (fun sum score -> score + sum) 0 round_scores

let () =
  let lines = Lib.extract_lines "bin/day2.txt" in
  print_newline ();
  print_endline "day 2";
  part1 lines |> print_int;
  print_newline ();
  part2 lines |> print_int;
  ()
