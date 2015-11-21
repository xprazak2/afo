angular.module('Afo.comics').controller('ComicsBaseCtrl',
  ['$scope', '$q', 'Comic', 'comicCount',
    function ($scope, $q, Comic, comicCount) {

      $scope.comic = null;

      var loadLast = function () {
        var result, success, error,
            deferred = $q.defer();

        success = function (response) {
          deferred.resolve(response);
          console.log(response);
        };

        error = function (response) {
          deferred.reject(response);
          console.log(response);
        };

        $scope.loading = true;
        Comic.last({}, success, error)
        return deferred.promise;
      };

      $scope.getLast = function () {
        loadLast().then(function (comic) {
          $scope.comic = comic;
          $scope.loading = false;
          console.log('get last');
        });
      };

    }
]);
