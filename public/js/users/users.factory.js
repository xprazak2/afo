angular.module('Afo.users').factory('User', ['AfoResource',
  function (AfoResource) {
    return AfoResource('/api/users/:id/:action', {id: '@id'}, {
      update: {method: 'PUT'}
    });
  }
]);