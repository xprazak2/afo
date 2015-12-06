angular.module('Afo').config(['$locationProvider', '$stateProvider', '$urlRouterProvider', 'Constants',
  function ($locationProvider, $stateProvider, $urlRouterProvider, Constants) {
    $locationProvider.html5Mode({
      enabled: true,
      //or get higher angular version instead
      requireBase: false
    });
    $urlRouterProvider.when("/", "/" + Constants.lastId)

    $stateProvider.state('layout', {
      abstract: true,
      controller: 'LayoutCtrl',
      templateUrl: 'layout/views/layout.html'
    })
    .state('layout.about', {
      url: '/{contentId:[a-z]+}',
      controller: 'AboutCtrl',
      templateUrl: 'contents/views/about.html'
    })
    .state('layout.disclaimer', {
      url: '/disclaimer',
      controller: 'DisclaimerCtrl',
      templateUrl: 'contents/views/disclaimer.html'
    })
    .state('layout.comics', {
      abstract: true,
      controller: 'ComicsBaseCtrl',
      template: '<div ui-view></div>'
    })
    .state('layout.comics.show', {
      url: '/:comicId',
      controller: 'ComicsShowCtrl',
      templateUrl: 'comics/views/comics-home.html'
    })
  }
]);
