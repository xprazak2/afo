angular.module('Afo.comics').controller('ComicsListCtrl',
  ['$scope', '$q', 'Comic', 'ngDialog',
    function ($scope, $q, Comic, ngDialog) {

      var loadComics, getComics;

      $scope.comicList = null;

      $scope.$on('ngDialog.templateLoading', function () {
        $scope.loading = true;
      });

      $scope.$on('ngDialog.templateLoaded', function () {
        $scope.loading = false;
      });

      loadComics = function () {
        $scope.loading = true;
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
          $scope.loading = false;
        });
      };

      $scope.deleteComic = function (comic) {
        $scope.loading = true;
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

      $scope.deleteTest = function (comic) {
        console.log("delete test");
        console.log(comic);
      };

      getComics();
    }
]);