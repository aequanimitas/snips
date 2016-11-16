const test = require('tape');

test((t) => {
  t.plan(5)
  var x = [], y = [];
  t.notOk([,,,].length === 0, 'falsy, this syntax is discouraged');
  x.length = 2;
  t.ok(x.length === 2, 'array.length property is not read-only');
  x = [1,2];
  x.length = 1;
  t.equal(x[1], undefined, 'x.length was adjusted, last element was "popped" from the object');
  x[100] = 12;
  t.ok(x.length === 101, 'array now becomes a sparse-array');
  y[Math.pow(2^32)] = 'limit';
  t.ok(y.length === 0, 'array object limit is 4,294,967,295');
});
