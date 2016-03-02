'aa bb'.split(' ').map(function(e) {
  return 'cc dd'.map(function(d) {
    return e + ' ' + d;
  });
});
