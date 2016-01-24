angular.element(document).ready(function () {
  "use strict";
  angular.bootstrap(document, Modules);
});

Modules = [
  'Afo.auth',
  'Afo',
  'Afo.layout',
  'Afo.comics',
  'Afo.contents',
  'Afo.directives',
  'Afo.services',
  'Afo.users',
];