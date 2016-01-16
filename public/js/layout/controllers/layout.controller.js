angular.module('Afo.layout').controller('LayoutCtrl',
  ['$scope', 'Constants', 'CurrentUser',
    function ($scope, Constants, CurrentUser) {

      $scope.firstId = Constants.firstId;
      $scope.lastId = Constants.lastId;
      $scope.ids = Constants.ids;
      $scope.currentUser = CurrentUser;

      $scope.$on('comicDeleted', function(event, id) {
        $scope.ids = $scope.ids.filter(function (listedId) {
          return id !== listedId;
        });

        $scope.firstId = $scope.ids[0] || -1
        $scope.lastId = $scope.ids[$scope.ids.length - 1] || -1
      });

      $scope.$on('logout', function (event) {
        $scope.currentUser = null;
      });

      $scope.getCurrentUser = function () {
        return $scope.currentUser;
      };

      $scope.authorized = function () {
        return !!$scope.currentUser;
      };

      $scope.logout = function () {
        $scope.currentUser = null;
      };
    }
]);