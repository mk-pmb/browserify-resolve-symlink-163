'use strict';

require('p-fatal');
const resolve = require('resolve');
const promisify = require('pify');

require('locally-symlinked-module-163'); // Help my linter detect this dep

function shorten(s) {
  return s.replace(/^\/\S+(?=\/[a-z\-]+ink-163\/)/g, '/…');
  // ^- The regexp's \S+ is greedy because GitHub CI uses paths with
  //    double project name.
}

async function discover(id) {
  console.log(id + '?');
  console.log('    node.js resolver:',
    shorten(require.resolve(id)));

  function wrap(cb) { resolve(id, cb); }
  console.log('    "resolve" module:',
    shorten(await promisify(wrap)().then(null, String)));

  console.log('');
}

async function main() {
  await discover('pify');
  await discover('locally-symlinked-module-163');
  await discover('global-module-163');
}

main();
