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
  t.equal(obj.x, 1, 'JS is naturally Call by Value, arguments are just copies and only exists until the end of the calling environment');
  reassignProp(obj2);
  t.notEqual(obj.x, 2, 'JS is also Call by Sharing! The modification made inside the called fn is also visible to the caller if the object is passed as an argument, what the function receives is the object reference. Modifying it inside the callee modifies the referenced object');
})
