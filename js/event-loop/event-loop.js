var fs = require('fs');

process.nextTick(function() {
  console.log('inside nextTick');
});

setImmediate(function() {
  console.log('CHECK phase: inside setImmediate, delay argument empty and will be called after setTimeout');
});

setTimeout(function() {
  console.log('TIMER phase: inside setTimeout, delay argument empty.');
});

setTimeout(function() {
  console.log('TIMER phase: inside setTimeout, testing same arg 0001.');
}, 2);

setTimeout(function() {
  console.log('TIMER phase: inside setTimeout, testing same arg 0000.');
}, 1);

process.nextTick(function() {
  console.log('inside nextTick, after setTimeouts are called and their callbacks are placed in the stack queue');
});

var x = function(cb) {
  var b = 0;
  while(b !== 1000000) {
    b++;
    if (b === 1000000) {
      process.nextTick(cb);
    }
  }
}

setTimeout(function() {
  console.log('This callback function is pushed immediately at the queue / task queue. The threshold passed is larger the 32');
}, 2147483648);

setTimeout(function() {
  console.log('TIMER phase: inside setTimeout, negative int argument.');
}, -1);

function y() {
  console.log('normal function call');
}

x(function() {
  console.log('done');
});

y();

/// visualizing call stack

var callStackCounter = 0;

function callStackSize() {
  console.log(callStackCounter++);
  callStackSize();
}

callStackSize();
