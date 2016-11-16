//for (var i = 1; i < 101; i += 1) {
//  console.log("", i % 3 ? i : "fizz");
//}

function repeat(times, body) {
  for (var i = 0; i < times; i += 1) body(i);
}

function unless(test, then) {
  if (!test) then();
}

repeat(100, function(i) {
  unless(i % 3 && i % 5, function() {
    unless(i % 3, function() {
      console.log('Fizz');
    })
  });
})
