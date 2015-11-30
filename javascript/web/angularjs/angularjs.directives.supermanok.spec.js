describe('Directives', function(){
  var elm, scope;
  describe('-- Basics --', function(){
    // load module instead of assigning it to a context
    beforeEach(module('DirectiveBasicsApp'));
    describe('supermanok and its peer directives', function() {
      it('loading mock module can be done on a per test basis', function(){
        angular.mock.module('angularjs.directives.supermanok.html');
        angular.mock.inject(function($rootScope, $compile){
          elm = angular.element(
            '<supermanok>' +
            '</supermanok>'
          );
          scope = $rootScope;
          $compile(elm)(scope);
          scope.$digest();
          expect(elm.find('span').length).toEqual(1);
          expect(elm.find('span').text()).toEqual('supermanok');
        });
      });
    });
  });
});
