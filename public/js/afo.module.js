angular.module('Afo', [

]);

angular.module('Afo').config(['$locationProvider',
  function ($locationProvider) {
    $locationProvider.html5Mode(true);
  }
]);