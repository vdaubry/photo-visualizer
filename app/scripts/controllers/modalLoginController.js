//see http://angular-ui.github.io/bootstrap/
angular.module('photoVisualizerApp')
  .controller('ModalInstanceCtrl', function ($scope, $rootScope, $modalInstance, $routeParams, AuthService, AUTH_EVENTS) {
    $scope.isLoginPage = true;

    $scope.credentials = {
      email: '',
      password: ''
    };

    $scope.login = function (credentials) {
      AuthService.login(credentials).then(function (result) {
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
        $modalInstance.close();
      }, function () {
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed);
      });
    };

    // UserSignin.signin({email: $scope.email, password: $scope.password}, function(token){
    // });
  });