'use strict';

/**
 * @ngdoc overview
 * @name photoVisualizerApp
 * @description
 * # photoVisualizerApp
 *
 * Main module of the application.
 */
angular
  .module('photoVisualizerApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/websiteList.html',
        controller: 'WebsiteListCtrl'
      })
      .when('/websites/:id', {
        templateUrl: 'views/websiteDetail.html',
        controller: 'WebsiteDetailCtrl'
      })
      .when('/websites/:website_id/posts/:id', {
        templateUrl: 'views/postDetail.html',
        controller: 'PostDetailCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
