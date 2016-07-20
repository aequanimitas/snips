var test = require('tape')

test(function(t) {
  t.plan(5);
  t.equal(undefined, void (function(){}));
  t.equal(undefined, void 0); 
 
  // alter in local scope
  // doing this in global scope might not work
  // eg: undefined = 1
  var undefined = 1;
  t.equal(undefined, 1);
  t.notEqual(undefined, void (function(){}));
  t.notEqual(undefined, void 1); 
  t.end();
});
