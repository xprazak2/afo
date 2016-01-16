angular.module('Afo.directives').directive('confirmModal',
  ['ngDialog',
    function (ngDialog) {
      return {
        restrict: 'A',
        scope: {
          model: "=",
          text: "@",
          itemName: "=",
          action: "&",
          working: "="
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
        var closeModal = function () {
          $scope.closeThisDialog('Closing value');
          $scope.working = false;
        };
        $scope.action().then(closeModal, closeModal);
      };

    }
])