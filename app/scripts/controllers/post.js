angular.module('photoVisualizerApp')
  .controller('PostListCtrl', function ($scope, $routeParams, Post) {
    Post.query({website_id: $routeParams.id}, function(posts) {
      $scope.posts = posts;
    });
  });

angular.module('photoVisualizerApp')
  .controller('PostDetailCtrl', function ($scope, $routeParams, Post, PostImage) {
    Post.get({website_id: $routeParams.website_id, id: $routeParams.id}, function(post) {
      $scope.post = post;
    });

    PostImage.query({post_id: $routeParams.id}, function(images) {
      $scope.images = images;
    });
  });
