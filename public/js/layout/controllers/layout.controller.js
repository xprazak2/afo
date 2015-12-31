angular.module('Afo.layout').controller('LayoutCtrl',
  ['$scope', 'Constants',
    function ($scope, Constants) {
      $scope.loading = true;

      $scope.firstId = Constants.firstId;
      $scope.lastId = Constants.lastId;
      $scope.ids = Constants.ids;

      $scope.$on('comicDeleted', function(event, id) {
        $scope.ids = $scope.ids.filter(function (listedId) {
          return id !== listedId;
        });

        $scope.firstId = $scope.ids[0] || -1
        $scope.lastId = $scope.ids[$scope.ids.length - 1] || -1
      });
    }
]);