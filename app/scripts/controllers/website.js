'use strict';

angular.module('photoVisualizerApp')
  .controller('WebsiteListCtrl', function ($rootScope, $scope, AUTH_EVENTS, Website, UserWebsite, AuthService) {
    if(!AuthService.getSession().userId) {
      $rootScope.$broadcast(AUTH_EVENTS.notAuthenticated);
    };
    
    UserWebsite.query({user_id: AuthService.getSession().userId, page: 1, per: 50}, function(websites) {
      $scope.websites = websites;
    });
  });

angular.module('photoVisualizerApp')
  .controller('WebsiteManagmentCtrl', function ($rootScope, $scope, AUTH_EVENTS, Website, UserWebsite, AuthService) {
    $scope.websites = [];

    $scope.hasWebsite = function(website) {
      var ids = []
      for(var index in $scope.userWebsites) {
        ids.push($scope.userWebsites[index].id)
      }
      return ids.indexOf(website.id) > -1
    }

    UserWebsite.query({user_id: AuthService.getSession().userId, page: 1, per: 50}, function(websites) {
      $scope.userWebsites = websites;
    });

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

    $scope.subscribe = function(website) {
      UserWebsite.save({user_id: AuthService.getSession().userId, website_id: website.id}, function() {
        $scope.userWebsites.push(website);
      });
    };

    $scope.unsubscribe = function(website) {
      UserWebsite.remove({user_id: AuthService.getSession().userId, id: website.id}, function() {
        for(var index in $scope.userWebsites) {
          if($scope.userWebsites[index].id == website.id) {
            $scope.userWebsites.splice(index, 1);
            break;
          }
        }
      });
    };
  });