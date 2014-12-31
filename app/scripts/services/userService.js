'use strict';

var userService = angular.module('photoVisualizerApp');

// userService.factory('UserImage', function($resource, ENV, AuthService) {
//   return $resource('http://'+ENV.url+'/users/:user_id/posts/:id/images.json', {user_id: "@user_id", id: "@id", authentication_token: AuthService.getSession().userToken},
//     {
//       query: {
//         method: 'GET',
//         isArray: true,
//         transformResponse: function(data, header) {
//           var images = JSON.parse(data).images
//           return images;
//         }
//       }
//     });
// });


userService.factory('UserWebsite', function($resource, ENV, AuthService) {
  return $resource('http://'+ENV.url+'/users/:user_id/websites/:id.json', {user_id: "@user_id", id: "@id", authentication_token: AuthService.getSession().userToken},
    {
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          var websites = JSON.parse(data).websites;
          return websites;
        }
      }
    });
});


userService.factory('UserPost', function($resource, ENV, AuthService) {
  return $resource('http://'+ENV.url+'/users/:user_id/websites/:website_id/posts/:id.json', {user_id: "@user_id", website_id: "@website_id",id: "@id", authentication_token: AuthService.getSession().userToken},
    {
      get: {
        method: 'GET',
        isArray: false,
        transformResponse: function(data, header) {
          var posts = JSON.parse(data).posts;
          return posts;
        }
      },
      update: { method:'PUT' }
    });
});

userService.factory('UserImage', function($resource, ENV, AuthService) {
  return $resource('http://'+ENV.url+'/users/:user_id/posts/:post_id/images/:id.json', {user_id: "@user_id", post_id: "@post_id",id: "@id", authentication_token: AuthService.getSession().userToken},
    {
      query: {
        method: 'GET',
        isArray: true,
        transformResponse: function(data, header) {
          var images = JSON.parse(data).images
          return images;
        }
      },
      update: { method:'PUT' }
    });
});