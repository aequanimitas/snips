var stack = 0;
var hi = {
  toString: function() {
    return 'Hi';
  }
}

console.trace(hi);

setTimeout(function() {
  console.trace('event loop will pass this to the stack only when the stack is clear');
  console.trace('hello');
}, 2000);

console.trace('nice');
