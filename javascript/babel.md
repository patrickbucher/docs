install babel:

    npm install babel-cli babel-preset-es2015

Convert `foo.js` (most recent ECMAScript) to `bar.js` (older ECMAScript 5):

    npx babel foo.js --out-file bar.js --presets babel-preset-es2015
