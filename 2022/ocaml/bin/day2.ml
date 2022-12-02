
let run () =
  let ic = In_channel.open_bin "bin/day2.txt" in
  let data = In_channel.input_all ic in
  let lines = String.split_on_char '\n' data in
  List.iter print_endline lines;