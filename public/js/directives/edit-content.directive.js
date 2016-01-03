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
  ['$scope', '$q', '$stateParams', '$sce', 'Content', 'ngNotify',
    function ($scope, $q, $stateParams, $sce, Content, ngNotify) {
      $scope.working = false;
      $scope.editing = false;
      $scope.trustAsHtml = $sce.trustAsHtml;

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
          ngNotify.set("Error occured: " + response.data.errors, "error");
        }

        var content = $scope.model;
        content.title = content.title || $stateParams.contentId;
        $scope.working = true;
        delete content.kram_content
        //TODO redefine method in factory
        if(content.id) {
          console.log(content.id)
          Content.update({content: content, id: content.id}, success, error);
        } else {
          Content.save({content: content}, success, error);
        }
      };
    }
])