var test = require('tape');


function converter(arg) {
  var t = 0;
  arg.split(" ").forEach(function(n) {
    if (n.indexOf('.') === -1) {
      t = parseFloat(n); 
    }
  })
  return t;
}

test('converts int', function(t) {
  t.plan(1)
  t.deepEqual(1, converter('1'), 'converts to int')
})
