module Queue = CCFQueue
module MarkersSet = Set.Make (Char)

type signal = { queue : char CCFQueue.t; pos : int }

let part1 lines =
  let first_line = List.hd lines in
  let signal =
    first_line
    |> String.fold_left
         (fun { queue; pos } c ->
           let is_unique_marker =
             MarkersSet.of_seq (Queue.to_seq queue) |> MarkersSet.cardinal == 4
           in
           if is_unique_marker then { queue; pos }
           else
             (* max queue size 4 *)
             let queue = queue |> Queue.cons c in
             let queue, _ =
               if Queue.size queue > 4 then
                 let q, c = Queue.take_back_exn queue in
                 (q, Some c)
               else (queue, None)
             in
             { queue; pos = pos + 1 })
         { queue = Queue.empty; pos = 0 }
  in
  signal.pos

let part2 _lines = 0

let () =
  let lines = Lib.extract_lines "bin/day6.txt" in
  print_endline "day 6";
  print_string "part 1: ";
  part1 lines |> print_int;
  print_newline ();
  print_string "part 2: ";
  part2 lines |> print_int;
  print_newline ();
  ()
