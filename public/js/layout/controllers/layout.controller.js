angular.module('Afo.layout').controller('LayoutCtrl',
  ['$scope', 'Constants',
    function ($scope, Constants) {
      $scope.loading = true;

      $scope.firstId = Constants.firstId;
      $scope.lastId = Constants.lastId;
      $scope.ids = Constants.ids;
    }
]);