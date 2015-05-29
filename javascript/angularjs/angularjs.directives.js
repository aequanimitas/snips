angular.module('DirectiveBasicsApp', []);
angular.module('DirectiveBasicsApp')
.directive('supermanok', function(){
  return {
    restrict: "E",
    templateUrl: "angularjs.directives.supermanok.html"
  };
});
