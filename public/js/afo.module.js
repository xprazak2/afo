angular.module('Afo', [
  'ui.router',
  'ngResource',
  'ngDialog',
  'ngNotify',
  'validation.match',
  'Afo.auth'
])
.run(['ngNotify', '$rootScope', 'Auth', '$location',
  function (ngNotify, $rootScope, Auth, $location) {
    ngNotify.config({
      position: 'top',
      theme: 'pitchy',
      button: 'false',
      duration: 2500,
      button: false
    });

    $rootScope.loading = false;
    $rootScope.$on('$stateChangeStart', function (event, toState) {
      $rootScope.loading = true;
      if (toState.authorize && !Auth.authorized() ) {
        $location.path("/unauthorized").replace();
      }
    });

  }
]);
