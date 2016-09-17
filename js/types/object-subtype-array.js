var test = require('tape');

test((t) => {
  t.plan(5);
  var a = [], b = [];
  a['one'] = 1;
  a['1'] = 10;
  a[-1] = 10;
  t.ok(a.hasOwnProperty('one'), 'Since JS Array is a subtype of Object, you can assigne properties to it the same way on how you assigne a value to an address');
  t.ok(a.length === 2, "When 'sparse' arrays are created, it initializes 'addresses' that come before it");
  t.equal(a[1], 10, 'I think coercion happens on array assignments');
  t.ok(a.hasOwnProperty('-1'), 'Because when you pass a number, it becomes a key');
  t.ok(a.hasOwnProperty(-1), 'Even if it does not make sense');
});
