var suspend = require('suspend'),
    resume = suspend.resume,
    fs = require('fs');

suspend(function*() {
  var data = yield fs.readFile('fizz.js', 'utf8', resume());
  console.log(data);
})();
