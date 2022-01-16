
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
1.  Search for "options" to find the demo output block.


Example output
--------------

see [example_output.txt](example_output.txt)

* You might be wondering about the duplicate project name in the last line.
  That's the correct path.
  GitHub Actions just chooses to organize its files this way.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
