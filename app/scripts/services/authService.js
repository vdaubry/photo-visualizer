'use strict';

var authService = angular.module('photoVisualizerApp');

authService.factory('AuthService', function ($http) {
  var authService = {};
  authService.session = {};

  authService.login = function (credentials) {
    return $http
      .post('http://private-f50cf-photovisualizer.apiary-mock.com/v1/users/sign_in', {"users": credentials})
      .success(function (data, status, headers, config) {
        authService.createSession(data.users.token, data.users.id);
        return data.users;
      });
  };

  authService.isAuthenticated = function () {
    return !!authService.session.userId;
  };

  authService.createSession = function(userToken, userId) {
    authService.session.userToken = userToken;
    authService.session.userId = userId;
  }

  authService.destroySession = function() {
    authService.session.userToken = null;
    authService.session.userId = null;
  }

  return authService;
})