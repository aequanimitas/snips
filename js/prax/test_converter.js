var test = require('tape');


function numHandler(n) {
  var t = (n.indexOf('.') !== -1) ? parseFloat(n) : parseInt(n);
  return t;
}

test('convert numbers', function(t) {
  t.plan(2);
  t.deepEqual(1, numHandler('1'), 'converts to int');
  t.equal(1.1, numHandler('1.1'), 'converts to float');
});

test('isSymbol', function(t) {

})
