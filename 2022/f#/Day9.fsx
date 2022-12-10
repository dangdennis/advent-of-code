let () =
    let lines = System.IO.File.ReadLines "Day9.txt"
    lines |> Seq.iter (printfn "%s" )
    ()
