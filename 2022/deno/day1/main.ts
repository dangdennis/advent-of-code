async function part1() {
  const decoder = new TextDecoder("utf-8");
  const data = await Deno.readFile("./day1.txt");
  const text = decoder.decode(data);
  const lines = text.split("\n");

  let elf = 1;
  let cals = 0;
  let highestCals = cals;

  for (let i = 0; i < lines.length; i++) {
    const cal = lines[i];
    if (!cal) {
      if (cals > highestCals) {
        highestCals = cals;
        elf = i;
      }
      cals = 0;
    } else {
      cals += parseInt(cal);
    }
  }

  console.log("highest elf", elf);
  console.log("highest elf", highestCals);
}

async function part2() {
  const decoder = new TextDecoder("utf-8");
  const data = await Deno.readFile("./day1.txt");
  const text = decoder.decode(data);
  const lines = text.split("\n");

  let elfCal = 0;
  const cals = [];

  for (let i = 0; i < lines.length; i++) {
    const cal = lines[i];
    if (!cal) {
      cals.push(elfCal);
      elfCal = 0;
    } else {
      elfCal += parseInt(cal);
    }
  }

  cals.sort((a, b) => b - a);

  console.log(cals.slice(0, 3).reduce((sum, cal) => sum + cal, 0));
}

await part1();
await part2();

export {};
