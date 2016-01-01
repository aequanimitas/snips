// for go weekly
var links = document.getElementsByClassName('main');
[].forEach.call(links, function(e) {
  console.log(`${e.innerHTML} - ${e.href}`);
}
//// gmail version
[].forEach.call(tables.getElementsByTagName('a'), function(e) { console.log(`${e.innerHTML} - ${e.href}`); })
//

// for node weekly
// you still need a UL handler
var trimmedTables = [].slice.call(document.getElementsByTagName('table'), 6);

trimmedTables[0].children[0].children[0].children[0].children[0].children[0].innerHTML
var tt = trimmedTables.filter(function(e,i) { if (i == 0) { return e } else { if (i % 2 === 0) { return e } } });
var tableLinks = tt.map(function(e) { return e.getElementsByTagName('a') })
tableLinks.forEach(function(e) {
  console.log(`${e[0].innerHTML} - ${e.href}`);
});
var uls	= [].slice.call(document.getElementsByTagName('ul'), 1)
uls[0].getElementsByTagName('a')
