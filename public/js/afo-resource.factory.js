//http://kirkbushell.me/angular-js-using-ng-resource-in-a-more-restful-manner/
angular.module('Afo').factory('AfoResource', ['$resource',

  function ($resource) {

    return function (url, paramDefaults, actions) {
      var defaults = {
        update: { method: 'put', isArray: false},
        create: { method: 'post'}
      };

      methods = angular.extend(defaults, actions);

      var resource = $resource(url, paramDefaults, methods);

      resource.prototype.$save = function () {
        if (!this.id) {
          return this.$create();
        }
        else {
          return this.$update();
        }
      };

      return resource;
    }

  }
]);
