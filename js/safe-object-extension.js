var test = require('tape');

test((t) => {
  t.plan(1);
  Number.prototype.toString = Number.prototype.toString || function() {
    return this;
  };
  var x = 2;
  t.equal(x.toString(), '2');
});
