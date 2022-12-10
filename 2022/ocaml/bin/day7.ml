type tree_node = {
  name : string;
  size : int;
  parent : tree_node option;
  kids : tree_node list;
}

let rec total_size node =
  List.fold_left (fun size kid -> size + total_size kid) node.size node.kids

let rec to_root node =
  match node.parent with Some p -> to_root p | None -> node

let update_parent_kids kid =
  match kid.parent with
  | Some p ->
      {
        p with
        kids = List.map (fun k -> if k.name = kid.name then kid else k) p.kids;
      }
  | None -> failwith "err"

let to_tree lines =
  List.map (String.split_on_char ' ') (List.tl lines)
  |> List.fold_left
       (fun node toks ->
         match toks with
         | [ "$"; "cd"; ".." ] -> update_parent_kids node
         | [ "$"; "cd"; dir ] ->
             let kid = List.find (fun kid -> kid.name = dir) node.kids in
             { kid with parent = Some node }
         | [ "dir"; dir ] ->
             let kid = { name = dir; size = 0; parent = None; kids = [] } in
             { node with kids = List.cons kid node.kids }
         | [ "$"; "ls" ] -> node
         | [ size; _ ] -> { node with size = node.size + int_of_string size }
         | _ -> failwith "err")
       { name = "/"; size = 0; parent = None; kids = [] }
  |> update_parent_kids |> to_root

let rec find f root =
  List.fold_left
    (fun l node -> l @ find f node)
    (if f root then [ root ] else [])
    root.kids

let part1 root =
  find (fun kid -> total_size kid <= 100000) root
  |> List.fold_left (fun sum kid -> sum + total_size kid) 0

let part2 root =
  let free = 70000000 - total_size root in
  let need = 30000000 - free in
  find (fun kid -> total_size kid >= need) root
  |> List.map (fun kid -> total_size kid)
  |> List.sort compare |> List.hd

let () =
  let tree = Arg.read_arg "bin/day7.txt" |> Array.to_list |> to_tree in

  part1 tree |> string_of_int |> print_endline
(* part2 tree |> string_of_int |> print_endline *)
