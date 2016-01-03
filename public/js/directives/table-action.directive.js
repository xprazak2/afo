angular.module('Afo.directives').directive('tableAction',
  [function () {
    return {
      restrict: 'A',
      scope: {
        content: '=',
        action: '&',
        model: '=',
        itemName: '='
      },
      controller: 'TableActionCtrl',
      templateUrl: '/directives/views/table-action.html'
    }
  }
])
.controller('TableActionCtrl',
  ['$scope', function ($scope) {

    $scope.working = false;

    $scope.$on('ngDialog.templateLoading', function (e, $dialog) {
      $scope.working = true;
    });

    $scope.$on('ngDialog.templateLoaded', function (e, $dialog) {
      $scope.working = false;
    });
  }
])