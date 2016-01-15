angular.module('Afo').config(['$locationProvider', '$stateProvider', '$urlRouterProvider', 'Constants',
  function ($locationProvider, $stateProvider, $urlRouterProvider, Constants) {
    $locationProvider.html5Mode({
      enabled: true,
      //or get higher angular version instead
      requireBase: false
    });
    $urlRouterProvider.when("/", "/" + Constants.lastId)

    var contentPages = ['about', 'disclaimer'].join('|');

    $stateProvider.state('layout', {
      abstract: true,
      controller: 'LayoutCtrl',
      templateUrl: '/layout/views/layout.html'
    })
    .state('layout.contents', {
      url: '/{contentId:' + contentPages + '}',
      controller: 'ContentsCtrl',
      templateUrl: '/contents/views/content.html'
    })
    .state('layout.comics', {
      abstract: true,
      controller: 'ComicsBaseCtrl',
      template: '<div ui-view></div>'
    })
    .state('layout.comics.list', {
      url: '/comics',
      controller: 'ComicsListCtrl',
      templateUrl: '/comics/views/comics-list.html'
    })
    .state('layout.comics.new', {
      url: '/comics/new',
      controller: 'ComicsNewCtrl',
      templateUrl: '/comics/views/comics-new.html'
    })
    .state('layout.comics.show', {
      url: '/:comicId',
      controller: 'ComicsShowCtrl',
      templateUrl: '/comics/views/comics-show.html'
    })
    .state('layout.users', {
      url: '/users',
      controller: 'UsersCtrl',
      templateUrl: '/usersl/views/users-show.html'
    })
  }
]);
