let extract_lines file_path =
  let ic = In_channel.open_bin file_path in
  let data = In_channel.input_all ic in
  String.split_on_char '\n' data