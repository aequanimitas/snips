var tbl = [].slice.call(document.getElementsByClassName('cl-table')[0].children[1].children).map(function(x){
  var cMain = x.children[0].children[0].innerText.split('(');
  return {
    companyName: cMain[0],
    symbol: cMain[1].replace(/\)/, ''),
    sector: x.children[2].innerText
  }
});
