'use strict';

angular.module('photoVisualizerApp')
  .controller('WebsiteListCtrl', function ($rootScope, $scope, AUTH_EVENTS, Website, UserSubscription, AuthService) {
    $scope.websites = [];

    UserSubscription.query({user_id: 1234, page: 1, per: 50}, function(subscriptions) {
      $scope.subscriptions = subscriptions;
    });
  });

angular.module('photoVisualizerApp')
  .controller('WebsiteManagmentCtrl', function ($rootScope, $scope, AUTH_EVENTS, Website, UserSubscription, AuthService) {
    $scope.websites = [];

    // if(JSON.stringify(AuthService.session)=='{}') {
    //   $rootScope.$broadcast(AUTH_EVENTS.notAuthenticated);
    // }
    // else {
    $scope.hasWebsite = function(website) {
      var website_ids = []
      for(var index in $scope.subscriptions) {
        if(index < $scope.subscriptions.length) {
          website_ids.push($scope.subscriptions[index].linked.websites[0].id)
        }
      }
      return (website_ids.indexOf(website.id) > -1)
    }

    UserSubscription.query({user_id: 1234, page: 1, per: 50}, function(subscriptions) {
      $scope.subscriptions = subscriptions
    });
    //}

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

    $scope.subscribe = function(website_id) {
      UserSubscription.save({user_id: 1234, website_id: website_id}, function(subscription) {
        $scope.subscriptions.push(subscription)
      });
    };

    $scope.unsubscribe = function(website_id) {
      var subscription;
      for(var index in $scope.subscriptions) {
        if($scope.subscriptions[index].linked.websites[0].id == website_id) {
          subscription = $scope.subscriptions[index];
          break;
        }
      }

      UserSubscription.remove({user_id: 1234, id: subscription.id}, function() {
        var index = $scope.subscriptions.indexOf(subscription);
        $scope.subscriptions.splice(index, 1);
      });
    };
  });

angular.module('photoVisualizerApp')
  .controller('WebsiteDetailCtrl', function ($scope, $routeParams, Website, WebsiteImage, Image, UserImage, AuthService) {
    UserImage.query({user_id:AuthService.session.userId, id: $routeParams.id}, function(images) {
      $scope.userImages = ids(images);
    });

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

  function ids(objects) {
  var ids = []
  for(var index in objects) {
    ids.push(objects[index].id)
  }
  return ids;
}
