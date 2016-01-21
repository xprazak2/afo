angular.module('Afo', [
  'ui.router',
  'ngResource',
  'ngDialog',
  'ngNotify',
  'validation.match',
])
.run(['ngNotify',
  function (ngNotify) {
    ngNotify.config({
      position: 'top',
      theme: 'pitchy',
      button: 'false',
      duration: 2500,
      button: false
    });
  }
]);
