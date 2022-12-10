open System

type node =
    { name: string
      size: int
      parent: Option<node>
      children: node[] }

let rec total_size node =
    node.children
    |> Seq.fold (fun size child -> size + (total_size child)) node.size

let rec to_root node =
    match node.parent with
    | Some p -> to_root p
    | None -> node

let add_child_to_parent child =
    match child.parent with
    | Some p -> { p with children = Array.map (fun k -> if k.name = child.name then child else k) p.children }
    | None -> failwith "no parent"


let to_tree (lines) =
    Seq.map (fun (s: string) -> s.Split ' ') (Seq.tail lines)
    |> Seq.fold
        (fun node tokens ->
            printfn "%A" tokens

            match tokens with
            | [| "$"; "cd"; ".." |] -> add_child_to_parent node
            | [| "$"; "cd"; dir |] ->
                let child = Array.find (fun child -> child.name = dir) node.children
                { child with parent = Some node }
            | [| "dir"; dir |] ->
                let child =
                    { name = dir
                      size = 0
                      parent = None
                      children = [||] } in { node with children = Array.concat [ [| child |]; node.children ] }
            | [| "$"; "ls" |] -> node
            | [| size; _ |] -> { node with size = node.size + int size }
            | _ -> failwith "invalid command")
        { name = "/"
          size = 0
          parent = None
          children = [||] }
    |> add_child_to_parent
    |> to_root


let rec find f root : node[] =
    Array.fold (fun l node -> Array.concat [ l; find f node ]) (if f root then [| root |] else [||]) root.children

let part1 root =
    find (fun kid -> total_size kid <= 100000) root
    |> Array.fold (fun sum kid -> sum + total_size kid) 0

let part2 root =
    let free = 70000000 - total_size root in
    let need = 30000000 - free in

    find (fun kid -> total_size kid >= need) root
    |> Array.map (fun kid -> total_size kid)
    |> Array.sort
    |> Array.head

let () =
    let tree = System.IO.File.ReadLines "Day7.txt" |> to_tree
    part1 tree |> printfn "Part 1: %d"
    part2 tree |> printfn "Part 2: %d"
