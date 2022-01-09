
<!--#echo json="package.json" key="name" underline="=" -->
browserify-resolve-symlink-163
==============================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Bug demo for https://github.com/browserify/resolve/issues/163
<!--/#echo -->


Usage
-----

The demo is meant to run on GitHub Actions:

1.  Navigate to this repo's "Actions" tab.
1.  Click the latest entry. (It should be the topmost one.)
1.  On the left, choose the node version you're interested in.
1.  On the right, locate the "Search logs" field.
1.  There should be a cogwheel/gear (⚙) icon next to it.
    Click that, it should open a menu.
1.  Select "View raw logs".
    * If logs are no longer available, clone this repo and read your own
      repo's logs, or file an issue here.
    * If your repo doesn't run the action, just commit some bogus activity
      like bumping the version in `package.json`.
1.  Search for "pify?" to find the relevant output.


Example output
--------------

```text
pify?
    node.js resolver: /…/browserify-resolve-symlink-163/mnt/projects/webdev/js/modules/pify/index.js
    "resolve" module: /…/browserify-resolve-symlink-163/home/node_modules/pify/index.js

locally-symlinked-module-163?
    node.js resolver: /…/browserify-resolve-symlink-163/mnt/projects/webdev/js/secret_modules/locally-symlinked-module-163/dummy.js
    "resolve" module: /…/browserify-resolve-symlink-163/home/demo/my-cool-app/node_modules/locally-symlinked-module-163/dummy.js

global-module-163?
    node.js resolver: /…/browserify-resolve-symlink-163/mnt/projects/webdev/js/secret_modules/global-module-163/dummy.js
    "resolve" module: Error: Cannot find module 'global-module-163' from '/home/runner/work/browserify-resolve-symlink-163/browserify-resolve-symlink-163/home/demo/my-cool-app'
```

* You might be wondering about the duplicate project name in the last line.
  That's the correct path.
  GitHub Actions just chooses to organize its files this way.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
