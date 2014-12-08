angular.module('photoVisualizerApp')
.controller('ApplicationController', function ($scope, $modal, AuthService, AUTH_EVENTS) {
  $scope.currentUser = null;
  $scope.isAuthorized = AuthService.isAuthorized;
  $scope.isLoginPage = false;

  $scope.$on(AUTH_EVENTS.notAuthenticated, function() {
    var modalInstance = $modal.open({
      templateUrl: 'views/modalLogin.html',
      controller: 'ModalInstanceCtrl'
    });
  });
});

