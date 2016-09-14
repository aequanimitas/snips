var test = require('tape');

function reassignArg(obj) {
  obj = {}
}

function reassignProp(obj) {
  obj.x = 2;
}

test('Mutations in JS', function(t) {
  var obj = { x: 1};
  t.plan(1);
  reassignArg(obj);
  t.equal(obj.x, 1, 'JS is Call by Value, arguments are just copies and only exists until the end of the calling environment');
  reassignProp(obj);
  t.notEqual(obj.x, 2, 'But why this happens?');
})
