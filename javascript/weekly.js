// for go weekly
var links = document.getElementsByClassName('main');
[].forEach.call(links, function(e) {
  console.log(`${e.innerHTML} - ${e.href}`);
}
