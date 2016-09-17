var test = require('tape');

test('Undeclareds and undefineds', (t) => {
  t.plan(5);
  var x, y = {};
  t.equal(typeof x, 'undefined', 'scoped variable undefined');
  t.equal(typeof a, 'undefined', 'variable not in scope is also undefined');
  t.throws(() => { return a; }, 'accessing variable not in scope throws error');
  t.throws(() => { return x.i; }, 'accessing property of undefined');
  t.doesNotThrow(() => { return y.i; }, 'literal notation does not throw error');
});
