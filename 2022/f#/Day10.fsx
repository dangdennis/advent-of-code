type program =
    { cycle: int
      sumSignal: int
      register: int }

type Instruction =
    | AddX of int
    | Noop

let run () =
    let lines = System.IO.File.ReadLines "Day10.txt"

    let cycleTargets = [ 20; 60; 100; 140; 180; 220 ]

    let targetedSignalsStrength p =
        if List.exists (fun c -> p.cycle = c) cycleTargets then
            p.register * p.cycle + p.sumSignal
        else
            p.sumSignal

    let parseLine (l: string) =
        match l.Split(' ') with
        | [| "addx"; v |] -> [| Noop; AddX(int v) |]
        | _ -> [| Noop |]

    let program2 () =
        let instructions = lines |> Seq.map parseLine

        instructions
        |> Seq.fold (fun flat_instructions i -> Seq.concat [ flat_instructions; i ]) []
        |> Seq.fold
            (fun p instr ->
                let newStrength = targetedSignalsStrength p

                printfn "cycle %d" p.cycle
                // printfn "new signal %d" newStrength
                printfn "register %d" p.register

                match instr with
                | AddX v ->
                    { p with
                        sumSignal = newStrength
                        cycle = p.cycle + 1
                        register = p.register + v }
                | Noop ->
                    { p with
                        cycle = p.cycle + 1
                        sumSignal = newStrength })
            { program.cycle = 1
              register = 1
              sumSignal = 0 }

    let p = program2 ()

    printfn "signal strength sum %d" p.sumSignal
    ()

run ()
