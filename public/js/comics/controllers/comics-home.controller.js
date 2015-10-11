angular.module('Afo.comics').controller('ComicsHomeCtrl',
  ['$scope', 'Comic',
    function ($scope, Comic) {

      var, success, error, load;

      success = function (response) {
        deferred.resolve(response);
        console.log("success " + reponse);
      };

      error = function (response) {
        deferred.reject(response);
        console.log("error " + response);
      };

      load = function () {
        var result,
            deferred = $q.defer();

        Comic.last({}, success, error)
        return deferred.promise;
      };
    }
])