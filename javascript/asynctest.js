loadSettings: function(done) {
  var file = fs.readFile("settings.json", function(err, data) {
    if (err) dataR = undefined;
    done();
  });
};

  beforeEach(function(done){
    ro.loadSettings(done);
  });
