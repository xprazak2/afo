angular.module('Afo.directives').directive('editContent',
  [function () {
    return {
      restrict: 'A',
      scope: {
        model: '='
      },
      templateUrl: '/directives/views/edit-content.html',
      controller: 'EditContentCtrl'
    }
  }
])
.controller('EditContentCtrl',
  ['$scope', '$q', '$stateParams', 'Content', 'ngNotify',
    function ($scope, $q, $stateParams, Content, ngNotify) {
      $scope.working = false;
      $scope.editing = false;

      $scope.saveContent = function () {
        var success, error,
            deferred = $q.defer();

        success = function (response) {
          deferred.resolve(response);
          $scope.model = response;
          $scope.editing = false;
          $scope.working = false;
          ngNotify.set("Content of '" + response.title + "' successfully changed!", "success");
          console.log(response)
        };

        error = function (response) {
          deferred.reject(response);
          $scope.working = false;
          ngNotify.set("Error occured: " + response.data.message, "error");
        }

        var content = $scope.model;
        content.title = content.title || $stateParams.contentId;
        $scope.working = true;
        Content.save({content: content}, success, error);
      };
    }
])