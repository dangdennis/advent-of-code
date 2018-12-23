const fs = require('fs');
const path = require('path');
const readline = require('readline');

const file = fs.createReadStream(path.join(__dirname, 'input.txt'));
const rl = readline.createInterface(file);

let freq = 0;

rl.on('line', (input) => {
  freq += Number(input);
});

rl.on('close', () => {
  console.log(`The resulting frequency is ${freq}`); // eslint-disable-line
});
