type program =
    { cycle: int
      sumSignal: int
      register: int }

type instruction =
    | AddX of int
    | Noop

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

let makeInstructions lines =
    lines
    |> Seq.map parseLine
    |> Seq.fold (fun flat_instructions i -> Seq.concat [ flat_instructions; i ]) []

let part1 () =

    lines
    |> makeInstructions
    |> Seq.fold
        (fun p instr ->
            let newStrength = targetedSignalsStrength p

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

type coord = { x: int; y: int }

type sprite = { pos: int[] }

type crt =
    { screen: string[][]
      sprite: sprite
      cursor: coord }

let part2 () =
    let startSprite = { sprite.pos = [| 0; 1; 2 |] }
    let litPixel = "#"
    let darkPixel = "."
    let screenWidth = 40
    let screenHeight = 6

    let blankScreen =
        [| for i in 1..screenHeight -> [| for i in 1..screenWidth -> darkPixel |] |]

    let rowWrap = screenWidth - 1

    let startRenderer =
        { screen = blankScreen
          sprite = startSprite
          cursor = { x = 0; y = 0 } }

    let updateCell row col el (matrix: array<array<string>>) = matrix[row][col] <- el

    makeInstructions lines
    |> Seq.fold
        (fun
            { screen = screen
              sprite = sprite
              cursor = cursor }
            instruction ->

            { screen =
                if Array.exists (fun e -> e = cursor.x) sprite.pos then
                    screen |> updateCell cursor.y cursor.x litPixel |> ignore
                    screen
                else
                    screen

              sprite =
                  match instruction with
                  | Noop -> sprite
                  | AddX v -> { pos = sprite.pos |> Array.map (fun p -> p + v) }

              cursor =
                  if rowWrap = cursor.x then
                      { x = 0; y = cursor.y + 1 }
                  else
                      { cursor with x = cursor.x + 1 } })
        startRenderer


let () =
    let p1 = part1 ()
    printfn "part 1: %d" p1.sumSignal

    let p2 = part2 ()
    printfn "part 2:"

    for row in p2.screen do
        printf "%A\n" (Array.fold (fun str str2 -> str + " " + str2) "" row)
