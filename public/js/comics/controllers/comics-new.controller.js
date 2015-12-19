angular.module('Afo.comics').controller('ComicsNewCtrl',
  ['$scope', 'Comic',
    function ($scope, Comic) {
      console.log("comics new controller")

      $scope.comic = new Comic();
      $scope.file = {};

      var success, error;

      success = function (response) {

      };

      error = function (response) {

      };

      $scope.saveComic = function () {
        console.log($scope.comic);
        console.log($scope.file);
        // $scope.comic.$save(success, error);
      };
    }
]);