angular.module('photoVisualizerApp')
  .controller('LoginCtrl', function ($scope, $routeParams, AuthService, AUTH_EVENTS) {
    $scope.isLoginPage = true;

    $scope.credentials = {
      username: '',
      password: ''
    };

    $scope.login = function (credentials) {
      AuthService.login(credentials).then(function (user) {
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
        $scope.setCurrentUser(user);
      }, function () {
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed);
      });
    };

    // UserSignin.signin({email: $scope.email, password: $scope.password}, function(token){
    // });
  });