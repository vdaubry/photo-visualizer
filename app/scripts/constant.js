'use strict';

angular.module('photoVisualizerApp')
.constant('AUTH_EVENTS', {
  loginSuccess: 'auth-login-success',
  loginFailed: 'auth-login-failed',
  logoutSuccess: 'auth-logout-success',
  sessionTimeout: 'auth-session-timeout',
  notAuthenticated: 'auth-not-authenticated',
  notAuthorized: 'auth-not-authorized'
})
.constant('ENV', {
  //url: 'localhost:3002/api/v1'
  //url: '92.222.1.55:3002'
  url: 'private-f50cf-photovisualizer.apiary-mock.com/v1'
});