angular.module('Afo.users').controller('UsersEditCtrl',
  ['$scope', '$state', '$q', 'User', 'ngNotify',
    function ($scope, $state, $q, User, ngNotify) {

      $scope.newPass = {};
      $scope.user = $scope.currentUser;

      $scope.saveUser = function () {
        var success, error,
          deferred = $q.defer();

          success = function (response) {
            deferred.resolve(response);
            console.log(response);
            $scope.working = false;
            $state.transitionTo("layout.users.show", {userId: $scope.user.id})
            ngNotify.set("Password successfully changed!", "success");
          };

          error = function (response) {
            deferred.reject(response);
            console.log(response);
            $scope.working = false;
            ngNotify.set("Error occured: " + response.data.message, "error");
          };

          $scope.user.password = $scope.newPass.password;
          $scope.working = true;
          User.update({user: $scope.user, id: $scope.user.id}, success, error);
          return deferred.promise;
      };
    }
]);