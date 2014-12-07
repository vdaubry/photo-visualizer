'use strict';

angular.module('photoVisualizerApp')
  .controller('WebsiteListCtrl', function ($scope, Website) {
    $scope.websites = [];

    $scope.$watch('page', function() {
      Website.query({page: $scope.page, per: $scope.per}, function(websites) {
        $scope.websites.push.apply($scope.websites, websites);
      });
    });

    $scope.page = 1;
    $scope.per = 50;

    $scope.loadMore = function() {
      $scope.page++
    };
  });

angular.module('photoVisualizerApp')
  .controller('WebsiteDetailCtrl', function ($scope, $routeParams, Website, WebsiteImage, Image) {
    $scope.userImages = [];

    Website.get({id: $routeParams.id}, function(website) {
      $scope.website = website;
    });

    WebsiteImage.query({website_id: $routeParams.id, id: "latest"}, function(images) {
      $scope.images = images;
    });

    $scope.saveImage = function(imageId) {
      Image.update({id: imageId}, function() {
        $scope.userImages.push(imageId);
      });
    };

    $scope.deleteImage = function(imageId) {
      Image.delete({id: imageId}, function() {
        var index = $scope.userImages.indexOf(imageId);
        $scope.userImages.splice(index, 1);
      });
    };
  });
