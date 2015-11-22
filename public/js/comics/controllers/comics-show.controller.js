angular.module('Afo.comics').controller('ComicsShowCtrl',
  ['$scope', '$q', '$stateParams', 'Comic', 'Constants',
    function ($scope, $q, $stateParams, Comic, Constants) {

      $scope.comic = $scope.comic || null;

      var loadComic, getComic, random;

      random = function () {
        return Math.floor(Math.random() * Constants.comicCount);
      };

      var neighbour = function (offset) {
        if($scope.comic) {
          var index = $scope.ids.indexOf($scope.comic.id + offset)
          if(index == -1 ) {
            return null;
          } else {
            return $scope.ids[index];
          }
        } else {
          return null;
        }
      }

      $scope.nextId = neighbour(1);
      $scope.previousId = neighbour(-1);
      $scope.randomId = Constants.ids[random()];

      loadComic = function (comicId) {
        $scope.loading = true;
        var succes, error,
          deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
          };

        error = function (response) {
          deferred.reject(response);
        };

        Comic.get({id: comicId}, success, error);
        return deferred.promise;
      }

      getComic = function (comicId) {
        loadComic(comicId).then(function (comic) {
          $scope.comic = comic;
          $scope.loading = false;
        });
      }

      getComic($stateParams.comicId);
    }
]);
