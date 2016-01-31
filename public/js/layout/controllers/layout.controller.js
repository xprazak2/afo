angular.module('Afo.layout').controller('LayoutCtrl',
  ['$scope', 'Constants', 'Auth', '$rootScope',
    function ($scope, Constants, Auth, $rootScope) {

      $scope.firstId = Constants.firstId;
      $scope.lastId = Constants.lastId;
      $scope.ids = Constants.ids;
      $scope.authorized = Auth.authorized;
      $scope.currentUser = Auth.getCurrentUser();

      $scope.$on('comicDeleted', function(event, id) {
        $scope.ids = $scope.ids.filter(function (listedId) {
          return id !== listedId;
        });

        $scope.firstId = $scope.ids[0] || 0
        $scope.lastId = $scope.ids[$scope.ids.length - 1] || 0
      });

      $scope.$on('logout', function (event) {
        Auth.logout();
        $scope.currentUser = null;
      });

      $scope.isLoading = function (value) {
        $rootScope.loading = value;
      }
    }
]);