var express = require('express'),
    app = express();

app.use(express.static('public'));
app.get('/', function(req, res) {
  res.sendFile('./public/index.html');
})

app.listen(process.env.PORT || 3000, function() {
  console.log('server listening at port ' + this.address().port);
});

