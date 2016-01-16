angular.module('Afo.comics').controller('ComicsNewCtrl',
  ['$scope', 'Comic', 'ngNotify',
    function ($scope, Comic, ngNotify) {

      $scope.comic = new Comic();
      $scope.file = {};
      $scope.working = false;

      var success, error, parseFileContent;

      success = function (response) {
        $scope.working = false;
        ngNotify.set('New comic sucessfully uploaded.', 'success');
      };

      error = function (response) {
        $scope.working = false;
        ngNotify.set(response.data.message, 'error');
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