open Belt;

let multiLineToList = str =>
  Js.String.split("\n", Js.String.trim(str))
  ->List.fromArray
  ->List.map(str => Js.String.trim(str));

let readFileIntoList = filename => {
  let file = Node.Fs.readFileSync("./src/" ++ filename ++ ".txt", `utf8);
  file->multiLineToList;
};