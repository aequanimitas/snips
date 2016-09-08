function y(val) {
  return (function(cp) {
    return cp === val
  })(val)
}

console.log(y(false))

// interpreter will complain about the free variable x not in scope
//console.log((function yy(y) { return x; })(2));
