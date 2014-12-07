'use strict';

angular.module('photoVisualizerApp')
  .controller('WebsiteListCtrl', function ($scope, Website) {
    $scope.$watch('page', function() {
      Website.query({page: $scope.page, per: $scope.per}, function(websites) {
        $scope.websites.push.apply($scope.websites, websites);
      });
    });

    $scope.page = 1;
    $scope.per = 2;
    $scope.websites = [];

    $scope.loadMore = function() {
      $scope.page++
    };
  });

angular.module('photoVisualizerApp')
  .controller('WebsiteDetailCtrl', function ($scope, $routeParams, Website, WebsiteImage) {
    Website.get({id: $routeParams.id}, function(website) {
      $scope.website = website;
    });

    WebsiteImage.query({website_id: $routeParams.id, id: "latest"}, function(images) {
      $scope.images = images;
    });
  });
