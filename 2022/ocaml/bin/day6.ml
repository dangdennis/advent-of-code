module Queue = CCFQueue
module MarkersSet = Set.Make (Char)

type marker = { queue : char CCFQueue.t; pos : int }

let find_marker first_line n =
  let queue_size = n in
  let marker =
    first_line
    |> String.fold_left
         (fun { queue; pos } c ->
           let is_unique_marker =
             MarkersSet.of_seq (Queue.to_seq queue)
             |> MarkersSet.cardinal == queue_size
           in
           if is_unique_marker then { queue; pos }
           else
             let queue =
               let queue = queue |> Queue.cons c in
               if Queue.size queue > queue_size then
                 match Queue.take_back queue with
                 | None -> queue
                 | Some (queue, _) -> queue
               else queue
             in
             { queue; pos = pos + 1 })
         { queue = Queue.empty; pos = 0 }
  in
  marker

let part1 lines =
  let first_line = List.hd lines in
  let marker = find_marker first_line 4 in
  marker.pos

let part2 lines =
  let first_line = List.hd lines in
  let marker = find_marker first_line 14 in
  marker.pos

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
