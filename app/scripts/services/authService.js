'use strict';

var authService = angular.module('photoVisualizerApp');

authService.factory('AuthService', function ($http, ENV) {
  var authService = {};
  
  authService.login = function (credentials) {
    return $http
      .post('http://'+ENV.url+'/users/sign_in.json', {"users": credentials})
      .success(function (data, status, headers, config) {
        authService.createSession(data.users.token, data.users.id);
        return data.users;
      });
  };

  authService.isAuthenticated = function () {
    return !!authService.getSession().userId;
  };

  authService.createSession = function(userToken, userId) {
    localStorage.setItem("userToken", userToken);
    localStorage.setItem("userId", userId);
  }
  
  authService.getSession = function() {
      return {userToken: localStorage.getItem("userToken"),
              userId: localStorage.getItem("userId") }
  }

  authService.destroySession = function() {
    localStorage.removeItem("userToken");
    localStorage.removeItem("userId");
  }

  return authService;
})