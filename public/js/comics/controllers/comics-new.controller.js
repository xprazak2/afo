angular.module('Afo.comics').controller('ComicsNewCtrl',
  ['$scope', 'Comic',
    function ($scope, Comic) {
      console.log("comics new controller")

      $scope.comic = new Comic();
      $scope.file = {};
      $scope.working = false;

      var success, error, parseFileContent;

      success = function (response) {
        $scope.working = false;
      };

      error = function (response) {
        $scope.working = false;
      };

      parseFileContent = function (dataString) {
        if (dataString) {
          return dataString.split(',')[1]
        } else {
          return "";
        }
      };

      $scope.saveComic = function () {
        $scope.working = true;
        $scope.comic.file = parseFileContent($scope.file.data);
        $scope.comic.name = $scope.file.name;
        Comic.save({comic: $scope.comic}, success, error);
      };
    }
]);