var test = require('tape');

function reassignArg(obj) {
  obj = {}
}

function reassignProp(obj) {
  obj.x = 2;
}

test('Mutations in JS', function(t) {
  var obj = { x: 1}, obj2 = { x: 1 };
  t.plan(2);
  reassignArg(obj);
  t.equal(obj.x, 1, 'JS is Call by Value, arguments are just copies and only exists until the end of the calling environment');
  reassignProp(obj2);
  t.notEqual(obj.x, 2, 'JS is also call by sharing! The modification made in the called fn is also visible to the caller since they share the same object, if an assignment is made to the argument, there is no effect on the caller');
})
