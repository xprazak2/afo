// http://stackoverflow.com/questions/17063000/ng-model-for-input-type-file
angular.module('Afo.directives').directive('fileread',
  [function () {
    return {
      scope: {
        fileread: "="
      },
      link: function (scope, element, attrs) {
        element.bind("change", function (changeEvent) {
          var reader = new FileReader();
          reader.onload = function (loadEvent) {
            scope.$apply(function () {
              scope.fileread = {
                lastModified: changeEvent.target.files[0].lastModified,
                lastModifiedDate: changeEvent.target.files[0].lastModifiedDate,
                name: changeEvent.target.files[0].name,
                size: changeEvent.target.files[0].size,
                type: changeEvent.target.files[0].type,
                data: loadEvent.target.result
              }
            });
          }
          reader.readAsDataURL(changeEvent.target.files[0]);
        });
      }
    }
  }]
);