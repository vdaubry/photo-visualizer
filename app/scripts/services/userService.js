'use strict';

var userService = angular.module('photoVisualizerApp');

userService.factory('UserImage', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/users/:user_id/websites/:id/images', {user_id: "@user_id", id: "@id"},
    {
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          var images = JSON.parse(data).images
          return images;
        }
      }
    });
});


userService.factory('UserWebsite', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/users/:user_id/websites/:id', {user_id: "@user_id", id: "@id"},
    {
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          var websites = JSON.parse(data).websites;
          return websites;
        }
      }
    });
});