angular.module('DirectiveBasicsApp', [])
  .directive('supermanok', function(){
    return {
      restrict: "E",
      template: "<b>supermanok</b>"
    };
  });
