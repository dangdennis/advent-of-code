'use strict';

const fs = require('fs');
const path = require('path');

function main() {
  const file = fs.readFileSync(path.join(__dirname, 'input.txt'), 'utf-8');
  const fileArr = file.split('\n').sort((a,b) => {
    if (a < b) return 1;
    if (a > b) return -1;
    return 0;
  });

  const candidates = [];

  for(let ptr1 = 0; ptr1 < fileArr.length; ptr1++) {
    const str1 = fileArr[ptr1];

    for(let ptr2 = 1; ptr2 < fileArr.length; ptr2++) {
      const str2 = fileArr[ptr2];
      if (countDiffs(str1, str2) === 1) {
        candidates.push(str1);
        candidates.push(str2);
      }
    }
  }

  console.log(candidates)
}

function countDiffs(str1, str2) {
  if (str1.length != str2.length) return 0; // Lazy edge case handling
  
  let diffs = 0;
  for (let i = 0; i < str1.length; i++) {
    if (str1[i] === str2[i]) diffs++;
  }

  return diffs;
}

main();

