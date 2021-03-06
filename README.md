# Tubity in Crystal with Kemal

## Installation

1. Install Crystal (http://crystal-lang.org/docs/installation/index.html)

2. Checkout

3. Install shards `$ crystal deps` (https://github.com/crystal-lang/shards)

4. Install and run redis server (http://redis.io)

4. Compile `$ crystal compile --release src/kml.cr`

## Usage

Run compiled:
`$ ./kml -e production`

### API

You need to send JSON requests like:
```json
{
  "url": "http://some.url"
}
```

Response is shortened URL like:
```json
{
  "url": "http://some.url",
  "shorten_url": "http://localhost:3000/s4"
}
```

#### Redis keys

All used keys are namespaced with `tubity:`


## Benchmark

Use `bench-rest` (https://github.com/jeffbski/bench-rest/)

With config like this:
```js
var benchrest = require('bench-rest');

var flow = {
  main: [
    { post: 'http://localhost:3000/s', json: {'url': 'http://mydata_kemal_#{INDEX}'} },
  ]
};
module.exports = flow;

benchrest(flow, { iterations: 10, limit: 100})
  .on('error', function (err, ctxName) { console.error('Failed in %s with err: ', ctxName, err); })
  .on('progress', function (stats, percent, concurrent, ips) {
    console.log('Progress: %s complete', percent);
   })
  .on('end', function (stats, errorCount) {
    console.log('error count: ', errorCount);
    console.log('stats', stats);
   });
```

With single polling:
`bench-rest -c 1 -n 100000 ./tubity.js`

And concurrency:
`bench-rest -c 16 -n 100000 ./tubity.js`

## Contributors

- [ababich](https://github.com/ababich) Alexey Babich - creator, maintainer
