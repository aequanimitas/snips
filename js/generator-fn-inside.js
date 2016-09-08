function fn1(a) {
  console.log(a);
}

function *fn2() {
  while(true) {
    fn1(yield);
  }
}

module.exports = fn2
