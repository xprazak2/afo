angular.module('Afo.comics').factory('Comic', ['AfoResource',
  function (AfoResource) {
    return AfoResource('/api/comics/:id/:action', {id: '@id'}, {
      update: {method: 'PUT'},
    });
  }
])