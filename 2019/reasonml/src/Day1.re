open Belt;

/* Day 1 https://adventofcode.com/2019/day/1 */
let masses = Utils.readFileIntoList("Day1Input");

let calcFuel = mass => {
  Js.Math.floor(mass /. 3.) - 2;
};

let totalFuel =
  masses
  ->List.map(mass => mass->Js.String.trim->float_of_string->calcFuel)
  ->List.reduce(0, (acc, next) => acc + next);

Js.log(totalFuel); /* 3457681 */