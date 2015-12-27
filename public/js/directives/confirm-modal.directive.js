angular.module('Afo.directives').directive('confirmModal',
  ['ngDialog',
    function (ngDialog) {
      return {
        restrict: 'A',
        scope: {
          model: "=",
          itemName: "=",
          action: "&"
        },
        link: function (scope, element, attrs) {
          element.on("click", function () {
            scope.$dialog = ngDialog.open({
              templateUrl: '/directives/views/confirm-modal.html',
              controller: 'ConfirmModalCtrl',
              scope: scope
            });
          });
        }
      };
    }
])
.controller('ConfirmModalCtrl',
  ['$scope',
    function ($scope) {

      $scope.confirm = function () {
        $scope.action();
        $scope.closeThisDialog('Closing value');
      };

    }
])