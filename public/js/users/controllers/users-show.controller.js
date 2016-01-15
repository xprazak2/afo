angular.module('Afo.users').controller('UsersShowCtrl',
  ['$scope', '$q','User',
    function ($scope, $q, User) {

      $scope.loading = $scope.loading || false;

      console.log("users list ctrl");
      $scope.user = $scope.currentUser
      console.log($scope.user);

    }
]);
