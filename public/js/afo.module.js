angular.module('Afo', [
  'ui.router',
  'ngResource',
]);

angular.module('Afo').config(['$locationProvider', '$stateProvider',
  function ($locationProvider, $stateProvider) {
    $locationProvider.html5Mode({
      enabled: true,
      //or get higher angular version instead
      requireBase: false
    });

    $stateProvider.state('layout', {
      abstract: true,
      templateUrl: 'layout/views/layout.html'
    })
    .state('layout.comics', {
      abstract: true,
      controller: 'ComicsBaseCtrl'
    })
    .state('layout.comics.home', {
      url: '/',
      controller: 'ComicsHomeCtrl',
      templateUrl: 'comics/views/comics-home.html'
    })

    .state('layout.about', {
      url: '/about',
      controller: 'AboutCtrl',
      templateUrl: 'contents/views/about.html'
    })
    .state('layout.disclaimer', {
      url: '/disclaimer',
      controller: 'DisclaimerCtrl',
      templateUrl: 'contents/views/disclaimer.html'
    })
  }
]);
