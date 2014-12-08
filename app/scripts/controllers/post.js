angular.module('photoVisualizerApp')
  .controller('PostListCtrl', function ($scope, $routeParams, Post) {
    $scope.posts = [];

    $scope.$watch('page', function() {
      Post.query({website_id: $routeParams.id, page: $scope.page, per: $scope.per}, function(posts) {
        $scope.posts = posts;
      });
    });

    $scope.page = 1;
    $scope.per = 25;

    $scope.nextPage = function() {
      $scope.page++;
    };

    $scope.previousPage = function() {
      $scope.page--;
    };
  });

angular.module('photoVisualizerApp')
  .controller('PostDetailCtrl', function ($scope, $routeParams, Post, PostImage, Image, UserImage) {
    UserImage.query({user_id:1, id: $routeParams.id}, function(images) {
      $scope.userImages = images;
    });

    $scope.shouldPaginate = true;
    $scope.maxSize=5;
    $scope.images = [];

    $scope.pageChanged = function(newPage) {
      PostImage.query({post_id: $routeParams.id, page: newPage, per: $scope.per}, function(images) {
        $scope.images = images;
      });
    };

    $scope.page = 1;
    $scope.per = 50;
    $scope.pageChanged($scope.page);

    Post.get({website_id: $routeParams.website_id, id: $routeParams.id}, function(post) {
      $scope.post = post;
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
