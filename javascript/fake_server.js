var http = require('http'),
    port = 3000,
    host = '127.0.0.1',
    server = http.createServer( function(req, res) {
      if (req.method === 'POST') {
        var body = '';
        req.on('data', function(data) {
          body += data;
          console.log('aggregate: ' + body);
        });
        req.on('end', function() {
          console.log('Body: ' + body);
        });
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('POST receieved');
      } else if (req.method === 'GET') {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('<html><body>GET receieved</body></html>');
      }
    });

server.listen(port, host);

server.on('request', function(req, res) {
  console.log('Received a '.concat(req.method).concat(' request'));
});
