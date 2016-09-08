function fib(x) {
  if(x === 0) return 0;
  if(x === 1) return 1;
  else return fib(x -2) + fib(x - 1);
}

function *gen(x) {
  var a = 0,
      b = 1,
      temp = 1;
  for(var ct = 1; ct <= x; ct += 1) {
    temp = a + b
    a = b;
    b = temp;
    yield temp;
  }
}

module.exports = {
  recursion: fib,
  generator: gen
}
