type program =
    { cycle: int
      sumSignal: int
      register: int }

type cycle =
    | AddX of int
    | Noop

let lines = System.IO.File.ReadLines "Day10.txt"

let parseLine (l: string) =
    match l.Split(' ') with
    | [| "addx"; v |] -> [| Noop; AddX(int v) |]
    | _ -> [| Noop |]

let makeCycles lines =
    lines
    |> Seq.map parseLine
    |> Seq.fold (fun cycles i -> Seq.concat [ cycles; i ]) []


let part1 () =
    let cycleTargets = [ 20; 60; 100; 140; 180; 220 ]

    let targetedSignalsStrength p =
        if List.exists (fun c -> p.cycle = c) cycleTargets then
            p.register * p.cycle + p.sumSignal
        else
            p.sumSignal

    lines
    |> makeCycles
    |> Seq.fold
        (fun p cycle ->
            let newStrength = targetedSignalsStrength p

            match cycle with
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
    let litPixel = "#"
    let darkPixel = "."
    let screenWidth = 40
    let screenHeight = 6
    let rowWrap = screenWidth - 1

    let startScreen =
        [| for i in 1..screenHeight -> [| for i in 1..screenWidth -> darkPixel |] |]

    let startSprite = { sprite.pos = [| 0; 1; 2 |] }

    let crt =
        { screen = startScreen
          sprite = startSprite
          cursor = { x = 0; y = 0 } }

    makeCycles lines
    |> Seq.fold
        (fun
            { screen = screen
              sprite = sprite
              cursor = cursor }
            cycle ->

            { screen =
                if Array.exists (fun e -> e = cursor.x) sprite.pos then
                    screen[cursor.y][cursor.x] <- litPixel
                    screen
                else
                    screen

              sprite =
                  match cycle with
                  | Noop -> sprite
                  | AddX v -> { pos = sprite.pos |> Array.map (fun p -> p + v) }

              cursor =
                  if rowWrap = cursor.x then
                      { x = 0; y = cursor.y + 1 }
                  else
                      { cursor with x = cursor.x + 1 } })
        crt


let () =
    let p1 = part1 ()
    printfn "part 1: %d" p1.sumSignal

    let p2 = part2 ()
    printfn "part 2:"
    for row in p2.screen do
        printf "%A\n" (Array.fold (fun str str2 -> str + " " + str2) "" row)
