angular.module('Afo.comics').controller('ComicsBaseCtrl',
  ['$scope', 'Comic',
    function ($scope, Comic) {

      $scope.getLast = function () {
        var result, success, error,
            deferred = $q.defer();

        success = function (response) {
          deferred.resolve(response);
          console.log("success " + reponse);
        };

        error = function (response) {
          deferred.reject(response);
          console.log("error " + response);
        };

        Comic.last({}, success, error)
        return deferred.promise;
      };

    }
]);
