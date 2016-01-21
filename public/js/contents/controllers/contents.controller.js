angular.module('Afo.contents').controller('ContentsCtrl',
  ['$scope', '$state', '$stateParams','$q', 'Content',
    function ($scope, $state, $stateParams, $q, Content) {

      $scope.content = $scope.content || new Content();

      var loadContent, getContent;

      loadContent = function (contentId) {
        $scope.loading = true;
        var succes, error,
          deferred = $q.defer();

        success = function (response) {
            deferred.resolve(response);
          };

        error = function (response) {
          deferred.reject(response);
        };

        Content.get({id: contentId}, success, error);
        return deferred.promise;
      };

      getContent = function (contentId) {
        var onSucc, onErr;
        onSucc = function (content) {
          $scope.content = content;
          $scope.loading = false;
        };
        onErr = function (error) {
          $scope.loading = false;
        };
        loadContent(contentId).then(onSucc, onErr);
      }

      getContent($stateParams.contentId);
    }
]);

