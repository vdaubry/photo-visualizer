'use strict';

var userService = angular.module('photoVisualizerApp');

userService.factory('UserSubscriptionImage', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/users/:user_id/subscription/:id/images', {user_id: "@user_id", id: "@id"},
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


userService.factory('UserSubscription', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/users/:user_id/subscriptions/:id', {user_id: "@user_id", id: "@id"},
    {
      save: {
        method:'POST',
        isArray: false,
        transformResponse: function(data, header) {
          var subscription = JSON.parse(data).subscriptions;
          return subscription;
        }
      },
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          var subscriptions = JSON.parse(data).subscriptions;
          return subscriptions;
        }
      }
    });
});