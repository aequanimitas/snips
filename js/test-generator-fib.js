var test = require('tape'),
    fib = require('./generator-fib'),
    recurse = fib.recursion,
    generator = fib.generator

test('Fib test, recursive', function(t) {
  t.plan(5);
  t.equal(0, recurse(0));
  t.equal(1, recurse(1));
  t.equal(2, recurse(3));
  t.equal(34, recurse(9));
  t.equal(55, recurse(10));
})

test('Fib test, generator', function(t) {
  var g = generator(12707896789254191234123);
  t.plan(5);
  t.equal(1, g.next().value);
  t.equal(2, g.next().value);
  t.equal(3, g.next().value);
  t.equal(5, g.next().value);
  t.equal(8, g.next().value);
})
