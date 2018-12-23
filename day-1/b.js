const fs = require('fs');
const path = require('path');
const readline = require('readline');

async function findRepeatedFrequency() {
  let found = false;
  let freq = 0;
  let freqMap = { 0: false };

  const file = fs.createReadStream(path.join(__dirname, 'input.txt'));
  const rl = readline.createInterface(file);

  for await (const line of rl) {
    freq += Number(line);
    if (!freqMap[freq]) {
      freqMap[freq] = false;
    } else {
      console.log(freq);
      return freq;
    }
  }
}

async function main() {
  const freq = await findRepeatedFrequency();
  console.log(`The first repeated frequency is ${freq}`);
}

main();
