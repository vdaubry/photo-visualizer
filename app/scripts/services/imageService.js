'use strict';

var postService = angular.module('photoVisualizerApp');

postService.factory('Image', function($resource) {
  return $resource('http://private-f50cf-photovisualizer.apiary-mock.com/v1/images/:id.json', {id: "@id"},
    {
      'update': { method:'PUT' }
    });
});