# How to run in watch mode

1. `yarn start` to build all reason files to js

2. `FILE=<filename> yarn start:js` to run a particular day's solution

example: `FILE=Day1.bs.js yarn start:js`

If you're not running in dev mode, just build reason and run `node src/<filename>`
