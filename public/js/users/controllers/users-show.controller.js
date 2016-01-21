angular.module('Afo.users').controller('UsersShowCtrl',
  ['$scope', '$state', '$http', '$q','User', 'ngNotify',
    function ($scope, $state, $http, $q, User, ngNotify) {

      $scope.loading = $scope.loading || false;
      $scope.working = false;
      $scope.user = $scope.currentUser;

      $scope.$on('ngDialog.templateLoading', function () {
        $scope.modalLoading = true;
      });

      $scope.$on('ngDialog.templateLoaded', function () {
        $scope.modalLoading = false;
      });

      $scope.logout = function () {
        $scope.working = true;
        var deferred = $q.defer();
        $http.get('/private/logout').then(function (response) {
          deferred.resolve(response);
          $scope.working = false;
          $scope.$emit("logout")
          ngNotify.set("You have successfully logged out. See ya!", "success");
          $state.transitionTo("layout.comics.show", {comicId: $scope.lastId});
        });

        return deferred.promise;
      };

    }
]);
