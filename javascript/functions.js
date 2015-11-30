var provideDefaults = function(a,b,cbfn) {
  if (!cbfn) {
    var cbfn = function(a,b) {
      // default to addition
      return (a + b);
    };
  }
  return cbfn(a,b);
}
