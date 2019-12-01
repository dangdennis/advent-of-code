'use strict';

const fs = require('fs');
const path = require('path');
const readline = require('readline');

async function calculateCheckSum() {
  let nTwoLetters = 0;
  let nThreeLetters = 0;

  try {
    const file = fs.createReadStream(path.join(__dirname, 'input.txt'));
    const rl = readline.createInterface(file);

    for await (const line of rl) {
      const letters = line.split('');
      const letterMap = new Map();

      letters.forEach((letter) => {
        if (!letterMap.has(letter)) {
          letterMap.set(letter, 1);
        } else {
          const curr = letterMap.get(letter);
          letterMap.set(letter, curr + 1);
        }
      });

      const [nTwos, nThrees] = countChecks(letterMap);
      nTwoLetters += nTwos;
      nThreeLetters += nThrees;
    }
    rl.close();
  } catch (e) {
    console.log('err: ', e);
  }

  return nThreeLetters * nTwoLetters;
}

function countChecks(map) {
  let hasThree = false;
  let hasTwo = false;

  for (let [_, count] of map) {
    if (!hasThree && count === 3) {
      hasThree = true;
    }
    if (!hasTwo && count === 2) {
      hasTwo = true;
    }
  }

  if (hasThree && hasTwo) return [1, 1];
  if (!hasThree && hasTwo) return [1, 0];
  if (!hasTwo && hasThree) return [0, 1];
}

async function main() {
  const checksum = await calculateCheckSum();
  console.log(`The checksum is ${checksum}`);
}

main();
