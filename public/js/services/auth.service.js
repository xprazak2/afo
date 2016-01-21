// angular.module('Afo.auth', []);

angular.module('Afo.services').service('Auth',
  ['CurrentUser',
     function (CurrentUser) {
      currentUser = CurrentUser;

      this.authorized = function () {
        return !!currentUser;
      };

      this.setCurrentUser = function (user) {
        currentUser = user;
      };

      this.getCurrentUser = function () {
        return currentUser;
      };

      this.logout = function () {
        currentUser = null;
      };
    }
]);