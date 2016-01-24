angular.module('Afo.comics').controller('ComicsListCtrl',
  ['$scope', '$q', 'Comic', 'ngDialog', 'ngNotify',
    function ($scope, $q, Comic, ngDialog, ngNotify) {

      var loadComics, getComics;

      $scope.comicList = null;
      $scope.working = false;

      $scope.$on('ngDialog.templateLoading', function () {
        $scope.isLoading(true);
      });

      $scope.$on('ngDialog.templateLoaded', function () {
        $scope.isLoading(false);
      });

      loadComics = function () {
        $scope.isLoading(true);
        var success, error,
            deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
            $scope.comicList = response;
          };

        error = function (response) {
          deferred.reject(response);
        };

        Comic.query(success, error);
        return deferred.promise;
      };

      getComics = function () {
        loadComics().then(function (comics) {
          $scope.isLoading(false);
        });
      };

      $scope.deleteComic = function (comic) {
        $scope.working = true;
        var success, error,
            deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
            ngNotify.set("Comic with title: '" + response.title + "' deleted. R u happy now?", 'success');
            $scope.comicList = $scope.comicList.filter(function (listedComic) {
              return listedComic.id !== response.id;
            });
            $scope.$emit('comicDeleted', response.id);
          };

        error = function (response) {
          deferred.reject(response);
          ngNotify.set("Failed to delete comic: " + response.data.message, 'error');
        };

        comic.$remove(success, error).then(function (data) {
          $scope.working = false;
        });
        return deferred.promise;
      };

      getComics();
    }
]);