[].map.call(document.getElementsByClassName('post-image-description'), function(e) { 
  var obj = {
    links: [] 
  };
  var container = e.textContent.split('\n').filter(function(a) { return a.length > 0 });
  // loop while
  // odd = title
  // even = link
  // http://imgur.com/gallery/jjc6E
  [].forEach.call(e.children, function(x) {
    obj.links.push(x.href);
  });
  return obj;
});
