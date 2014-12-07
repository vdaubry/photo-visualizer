'use strict';

var postService = angular.module('photoVisualizerApp');

postService.factory('Post', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/websites/:website_id/posts/:id', {website_id: "@website_id", id: "@id"},
    {
      get: {
        method: 'GET',
        isArray: false,
        transformResponse: function(data, header) {
          return JSON.parse(data).posts;
        }
      },
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          return JSON.parse(data).posts;
        }
      }
    });
});

websiteService.factory('PostImage', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/posts/:post_id/images/:id', {post_id: "@post_id", id: "@id"},
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
