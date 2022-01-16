'use strict';

require('p-fatal');
const resolve = require('resolve');
const resolvePkgInfo = require('resolve/package.json');
const promisify = require('pify');

require('locally-symlinked-module-163'); // Help my linter detect this dep

console.log('"resolve" module version:', resolvePkgInfo.version);

function shorten(s) {
  return s.replace(/\/\S+(?=\/[a-z\-]+ink-163\/)/g, '/…');
  // ^- The regexp's \S+ is greedy because GitHub CI uses paths with
  //    double project name.
}

async function logResolve(id, opt) {
  function wrap(cb) { resolve(id, { ...opt }, cb); }
  const found = shorten(await promisify(wrap)().then(null, String));
  if (opt) {
    console.log('     `- with options: %s <- %o', found, opt);
  } else {
    console.log('    "resolve" module: %s', found);
  }
}

async function discover(id) {
  console.log('');
  console.log(id + '?');
  console.log('    node.js resolver:',
    shorten(require.resolve(id)));
  await logResolve(id);
  await logResolve(id, { preserveSymlinks: false });
}

async function main() {
  await discover('pify');
  await discover('locally-symlinked-module-163');
  await discover('via-homedot-modules-163');
  await discover('via-homedot-libraries-163');
}

main();
