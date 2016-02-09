var links = function(rgx) {
  var tuts = [].filter.call(document.getElementsByTagName('a'), function(e) {
    return rgx.test(e.href);
  });
  tuts = tuts.map(function(e) {
    return `- ${e.innerHTML} -- ${e.href}`;
  });
  return tuts;
};

(function(console){
  console.save = function(data, filename){
    if(!data) {
      console.error('Console.save: No data')
      return null;
    }
    if(!filename) filename = 'console.json'
    if(typeof data === "object"){
       data = JSON.stringify(data, undefined, 4)
    }
    var blob = new Blob([data], {type: 'text/json'}),
        e    = document.createEvent('MouseEvents'),
        a    = document.createElement('a')
    a.download = filename
    a.href = window.URL.createObjectURL(blob)
    a.dataset.downloadurl =  ['text/json', a.download, a.href].join(':')
    e.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null)
    a.dispatchEvent(e)
  }
})(console);

function createFile(pttrn) {
  var fileDate = document.getElementsByClassName('g3')[0].innerHTML.split(' ').slice(0,2);
      fileDate[1] = fileDate[1] < 10 ? '0' + fileDate[1] : fileDate[1];
      fileDate.push(new Date().getFullYear());
  var fileName = document.getElementsByClassName('gD')[0].innerHTML.replace(' ','').toLowerCase() + '_' + fileDate.join('') + '.md';
  console.save(links(new RegExp(pttrn)).join("\r\n"), fileName);
  return fileName;
}
