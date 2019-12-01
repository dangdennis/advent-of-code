open Belt;

let readFileIntoList = filename => {
  let file = Node.Fs.readFileSync("./src/" ++ filename ++ ".txt", `utf8);
  Js.String.split("\n", file)->List.fromArray;
};