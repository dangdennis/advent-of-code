/* Day 1 https://adventofcode.com/2019/day/1 */
open Belt;

/* Part 1 */
let modules = Utils.readFileIntoList("Day1Input");

let calcFuel = mass => (mass /. 3.)->Js.Math.floor_float -. 2.;

let totalFuelPart1 =
  modules
  ->List.map(mass => mass->Js.String.trim->float_of_string->calcFuel)
  ->List.reduce(0., (acc, next) => acc +. next);

Js.log2("total fuel for part 1 = ", totalFuelPart1); /* 3457681 */

/* Part 2 */
let rec calcFuelRec = mass => {
  let belowZero = mass < 9.;
  if (belowZero) {
    0.;
  } else {
    let fuelReq = calcFuel(mass);
    calcFuelRec(fuelReq) +. fuelReq;
  };
};

let totalFuelPart2 =
  modules
  ->List.map(mass => mass->Js.String.trim->float_of_string->calcFuelRec)
  ->List.reduce(0., (+.));

Js.log2("total fuel for part 2 = ", totalFuelPart2) /* )*/; /* 5183653 */