const fs = require('fs');
const path = require('path');
const readline = require('readline');

async function findRepeatedFrequency() {
  let found = false;
  let freq = 0;
  let freqMap = new Map();

  try {
    while (!found) {
      const file = fs.createReadStream(path.join(__dirname, 'input.txt'));
      const rl = readline.createInterface(file);
      for await (const line of rl) {
        freq += Number(line);
        if (freqMap.get(freq) === undefined) {
          freqMap.set(freq, false);
        } else {
          freqMap.set(freq, true);
          found = true;
          return freq;
        }
      }
      rl.close();
    }
  } catch (e) {
    console.log('err: ', e);
  }

  return null;
}

async function main() {
  const freq = await findRepeatedFrequency();
  console.log(`The first repeated frequency is ${freq}`);
}

main();
