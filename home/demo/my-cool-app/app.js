'use strict';

require('p-fatal');
const resolve = require('resolve');
const resolvePkgInfo = require('resolve/package.json');
const promisify = require('pify');

require('locally-symlinked-module-163'); // Help my linter detect this dep

const resoOpt = {
};

console.log('"resolve" module version:', resolvePkgInfo.version,
  '| options:', resoOpt);

function shorten(s) {
  return s.replace(/^\/\S+(?=\/[a-z\-]+ink-163\/)/g, '/…');
  // ^- The regexp's \S+ is greedy because GitHub CI uses paths with
  //    double project name.
}

async function discover(id) {
  console.log('');
  console.log(id + '?');
  console.log('    node.js resolver:',
    shorten(require.resolve(id)));

  function wrap(cb) { resolve(id, resoOpt, cb); }
  console.log('    "resolve" module:',
    shorten(await promisify(wrap)().then(null, String)));
}

async function main() {
  await discover('pify');
  await discover('global-modules');
  await discover('locally-symlinked-module-163');
  await discover('via-homedot-modules-163');
  await discover('via-homedot-libraries-163');
}

main();
