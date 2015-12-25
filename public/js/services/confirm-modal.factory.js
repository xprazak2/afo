angular.module('Afo.services').factory('ConfirmModal',
  ['btfModal',
    function (btfModal) {
      return btfModal({
        controller: 'ConfirmModalCtrl',
        controllerAs: 'modal',
        templateUrl: '/services/views/confirm-modal.html'
      });
    }
])
.controller('ConfirmModalCtrl',
  ['ConfirmModal',
    function (ConfirmModal) {
      this.deactivate = ConfirmModal.deactivate;
    }
])