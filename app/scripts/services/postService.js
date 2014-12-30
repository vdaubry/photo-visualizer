'use strict';

var postService = angular.module('photoVisualizerApp');

postService.factory('Post', function($resource, ENV) {
  return $resource('http://'+ENV.url+'/websites/:website_id/posts/:id.json', {website_id: "@website_id", id: "@id"},
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

websiteService.factory('PostImage', function($resource, ENV) {
  return $resource('http://'+ENV.url+'/posts/:post_id/images/:id.json', {post_id: "@post_id", id: "@id"},
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
