angular.module('Afo', [
  'ui.router',
  'ngResource',
]);

angular.module('Afo').config(['$locationProvider', '$stateProvider',
  function ($locationProvider, $stateProvider) {
    $locationProvider.html5Mode({
      enabled: true,
      //or bump angular version instead
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
  }
]);
