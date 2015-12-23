angular.module('Afo.comics').controller('ComicsShowCtrl',
  ['$scope', '$q', '$stateParams', 'Comic', 'Constants',
    function ($scope, $q, $stateParams, Comic, Constants) {

      $scope.comic = $scope.comic || null;

      var loadComic, getComic, random, neighbour, chooseRandom, findNeighbours,
          markNavigation;

      neighbour = function (offset) {
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
      };

      findNeighbours = function () {
        $scope.nextId = neighbour(1);
        $scope.previousId = neighbour(-1);
      };

      random = function () {
        return Math.floor(Math.random() * Constants.comicCount);
      };

      chooseRandom = function () {
        do {
          $scope.randomId = $scope.ids[random()];
        }
        while($scope.randomId == $scope.comic.id);
      };

      markNavigation = function () {
        $scope.firstComic = $scope.firstId == $scope.comic.id;
        $scope.lastComic = $scope.lastId == $scope.comic.id;
      };

      loadComic = function (comicId) {
        $scope.loading = true;
        var succes, error,
          deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
            // TODO: message
          };

        error = function (response) {
          deferred.reject(response);
          // TODO: message
        };

        Comic.get({id: comicId}, success, error);
        return deferred.promise;
      }

      getComic = function (comicId) {
        if ($scope.ids.length > 0) {
          loadComic(comicId).then(function (comic) {
            $scope.comic = comic;
            if(comic.id) {
              chooseRandom();
              findNeighbours();
              markNavigation();
            }
            $scope.loading = false;
          });
        } else {
          $scope.loading = false;
        }
      }

      getComic($stateParams.comicId);
    }
]);
