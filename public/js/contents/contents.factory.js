angular.module('Afo.contents').factory('Content', ['AfoResource',
  function (AfoResource) {
    return AfoResource('/api/contents/:id/:action', {id: '@id'}, {
      update: {method: 'PUT'}
    });
  }
]);