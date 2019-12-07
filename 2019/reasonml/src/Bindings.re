module Tree = {
  type t;
  [@bs.new] [@bs.module] external createTree: 'a => t = "easy-tree";
  [@bs.send] external walk: (t, 'a => unit) => unit = "walk";
  [@bs.send] external walkPath: (t, ~path: string, 'a => unit) => t = "walk";
  external toJson: t => Js.Json.t = "%identity";
};