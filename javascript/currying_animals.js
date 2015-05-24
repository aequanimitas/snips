function babyAnimals(handler) {
  return function(babyAnimal) {
    return ''.concat(handler).concat(' is a handler of ').concat(babyAnimal);
  }
}

var foo_handler = babyAnimals('Foo');
var baz_handler = babyAnimals('Baz');

console.log(foo_handler('Tigers'));
console.log(baz_handler('Elephants'));
