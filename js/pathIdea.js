var qq = 'aa bb'.split(' ').map(function(e) {
  return 'cc dd'.split(' ').map(function(d) {
    return e + ' ' + d;
  });
}).reduce(function(a, b) {
  return a.concat(b);
});

console.log(qq);
