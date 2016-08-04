function y(val) {
  return (function(cp) {
    return cp === val
  })(val)
}

console.log(y(false))
