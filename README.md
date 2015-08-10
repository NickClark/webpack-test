# webpack-test
Testing an ideal build setup

## Goals

This setup (illustrated by the `webpack-desired.config.coffee`) tries to configure a build system that satisfies the following criteria:

1.  Entry files are automatically detected as the `js` or `coffee` files located _directly_ under the scripts folder. Adding a new entry is as easy as adding a new file. That's it!
2.  There is a special entry file, named `vendor`, that is a special case. Any vendored assets can be required here without affecting the building of any of the other bundles. (This is good, since it's usually these that slow down builds)
3.  A `common.js` is created whenever there is two or more (not including `vendor`) entries that share some of the same modules.
4.  Vendored assets should not affect the build time of the other entries.
5.  Required CSS assets should be fast, and not affect the build time of the JS assets.

## Running

To see the issue, do the following:

1. Clone the repo
2. Run `npm run expected` and make a change to the `app/scripts/material-expected.coffee`
3. Notice the compile times both for initial build an the incremental build
4. Run `npm run desired` and make a change to the `app/scripts/material-expected.coffee`
5. Notice the compile times both for initial build an the incremental build

The `desired` config is a fully loaded config trying to fullfill the goals mentioned above.
The `expected` config is a gimped config designed to show the expected performance.

## Questions

1. Why is the sass build so slow?!
2. Why does the vendor entry affect the the other entries? Adding seconds to their build times. What I really need is to be able to iterate quickly, with the performance seen when just building the main entry by itself.
