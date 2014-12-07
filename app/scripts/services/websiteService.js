'use strict';

var websiteService = angular.module('photoVisualizerApp');

websiteService.factory('Website', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/websites/:id', {},
    {
      get: {
        method: 'GET',
        isArray: false,
        transformResponse: function(data, header) {
          return JSON.parse(data).websites;
        }
      },
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          return JSON.parse(data).websites;
        }
      }
    });
});


websiteService.factory('WebsiteImage', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/websites/:website_id/images/:id', {website_id: "@website_id", id: "@id"},
    {
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          return JSON.parse(data).images;
        }
      }
    });
});
