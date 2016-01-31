angular.module('Afo').config(['$locationProvider', '$stateProvider', '$urlRouterProvider', 'Constants',
  function ($locationProvider, $stateProvider, $urlRouterProvider, Constants) {
    $locationProvider.html5Mode({
      enabled: true,
      //or get higher angular version instead
      requireBase: false
    });
    $urlRouterProvider.when("/", "/" + Constants.lastId);
    $urlRouterProvider.otherwise("/unknown");

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
      templateUrl: '/comics/views/comics-list.html',
      authorize: true
    })
    .state('layout.comics.new', {
      url: '/comics/new',
      controller: 'ComicsNewCtrl',
      templateUrl: '/comics/views/comics-new.html',
      authorize: true
    })
    .state('layout.comics.show', {
      url: '/{comicId:int}',
      controller: 'ComicsShowCtrl',
      templateUrl: '/comics/views/comics-show.html',
    })
    .state('layout.users', {
      abstract: true,
      template: '<div ui-view></div>'
    })
    .state('layout.users.show', {
      url: '/users/:userId',
      controller: 'UsersShowCtrl',
      templateUrl: '/users/views/users-show.html',
      authorize: true
    })
    .state('layout.users.edit', {
      url: '/users/:userId/edit',
      controller: 'UsersEditCtrl',
      templateUrl: '/users/views/users-edit.html',
      authorize: true
    })
    .state('unauthorized', {
      url: '/unauthorized',
      templateUrl: '/layout/views/unauthorized.html'
    })
    .state('layout.unknown', {
      url: '/unknown',
      controller: 'UnknownCtrl',
      templateUrl: '/layout/views/unknown.html'
    });
  }
]);
