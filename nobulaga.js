(function(blah){
  w=window,
  d=document;
  x=d.getElementsByClassName('yt-shelf-grid-item');
  w.addEventListener('scroll', function(){
    Array.prototype.filter.call(x, function(y){
      if(y.innerHTML.includes(blah))
        y.style.display='none';
      return cond;
    })
  })
})('eatbulaga1979');
