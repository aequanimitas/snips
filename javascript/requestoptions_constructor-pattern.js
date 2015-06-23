function RequestOptions() {
  this.host = "192.168.254.254",
  this.path = "";
  this.hasAuth = false 
}

RequestOptions.prototype.needsAuth = function(hasAuth) {
  this.hasAuth = hasAuth;
  return this;
};

module.exports = RequestOptions;
