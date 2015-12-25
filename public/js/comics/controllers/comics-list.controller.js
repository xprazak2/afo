angular.module('Afo.comics').controller('ComicsListCtrl',
  ['$scope', '$q', 'Comic', 'ConfirmModal',
    function ($scope, $q, Comic, ConfirmModal) {

      var loadComics, getComics;

      $scope.comicList = null;

      loadComics = function () {
        $scope.loading = true;
        var success, error,
            deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
            // TODO: message
            $scope.comicList = response;
          };

        error = function (response) {
          deferred.reject(response);
          // TODO: message
        };

        Comic.query(success, error);
        return deferred.promise;
      };

      getComics = function () {
        loadComics().then(function (comics) {
          console.log(comics);

          $scope.loading = false;
        });
      };

      $scope.deleteComic = function (comic) {
        // $scope.loading = true;
        var success, error,
            deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
            // TODO: message
            $scope.comicList = $scope.comicList.filter(function (listedComic) {
              return listedComic.id !== response.id;
            });
          };

        error = function (response) {
          deferred.reject(response);
          // TODO: message
        };

        comic.$remove(success, error).then(function (data) {
          $scope.loading = false;
        });
      };

      $scope.deleteModal = function (comic) {
        ConfirmModal.activate();
      }

      getComics();
    }
]);