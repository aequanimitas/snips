var fetch = require('node-fetch');

var cachedFetch = function(url, opts) {
  var key = url,
      cached = localStorage.getItem(key);
      cachedTS = localStorage.getItem(key+':ts');
  if (cached !== null && cachedTS !== null) {
    console.log('cache not empty...');
    var age = (Date.now() - cachedTS) / 1000;
    if(age < opts.seconds) {
      console.log('returning cache...');
      var response = new Response(new Blob([cached]));
      return Promise.resolve(response);
    } else {
      console.log('clearing localStorage...');
      console.log(key+':ts');
      localStorage.removeItem(key);
      localStorage.removeItem(key+':ts');
    }
  } else {
    console.log('cache time might be expired, caching new data...');
    return fetch(url).then(function(response) {
      console.log('fetched');
      return response.clone().text;
    }).then(function(data) {
      console.log('storing to localStorage');
      localStorage.setItem(key, data);
      localStorage.setItem(key+':ts', Date.now());
    })
  }
}

cachedFetch('https://yts.ag/api/v2/list_movies.json', { seconds: 60 })
