angular.module('Afo.comics').factory('Comic', ['AfoResource',
  function (AfoResource) {
    return AfoResource('/api/comics/:id/:action', {id: '@id'}, {
      update: {method: 'PUT'},
      first: {method: 'GET', params: {action: 'first'}},
      last: {method: 'GET', params: {action: 'last'}},
      random: {method: 'GET', params: {action: 'random'}},
    });
  }
])