angular.module('DirectiveBasicsApp', []);
angular.module('DirectiveBasicsApp')
.directive('supermanok', function(){
  return {
    restrict: "E",
    template: "<span>supermanok</span>"
  };
});
