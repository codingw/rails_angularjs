var myApp = angular.module('myapplication', ['ngRoute', 'ngResource']);

//
//factories
//
myApp.factory('Collections', ['$resource',function($resource){
  return $resource('/collections', {},{
    query: { method: 'GET', isArray: true },
    create: { method: 'POST' }
  })
}]);

myApp.factory('Collection', ['$resource', function($resource){
  return $resource('/collections/:id', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id'} }
  });
}]);

//
//routes
//
myApp.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/collections',{
      templateUrl: '/templates/collections/index.html',
      controller: 'CollectionListCtr'
    });
    $routeProvider.when('/collections/new', {
     templateUrl: '/templates/collections/new.html',
     controller: 'CollectionAddCtr'
    });
    $routeProvider.when('/collections/:id/edit', {
     templateUrl: '/templates/collections/edit.html',
     controller: "CollectionUpdateCtr"
    });
    $routeProvider.otherwise({
     redirectTo: '/collections'
    });
  }
]);

//
//actions
//
myApp.controller("CollectionListCtr", ['$scope', '$resource', 'Collections', 'Collection', '$location', function($scope, $resource, Collections, Collection, $location) {
  $scope.collections = Collections.query(); //it's getting collection collection
}]);

myApp.controller("CollectionAddCtr", ['$scope', '$resource', 'Collections', '$location', function($scope, $resource, Collections, $location) {
  $scope.save = function () {
    if ($scope.collectionForm.$valid){
      Collections.create({contractno: $scope.collectionForm.contractno.$viewValue, kode_cabang: $scope.collectionForm.kode_cabang.$viewValue}, function(){
      $location.path('/');
    }, function(error){
      console.log(error)
    });
  }
 }
}]);

myApp.controller("CollectionUpdateCtr", ['$scope', '$resource', 'Collection', '$location', '$routeParams', function($scope, $resource, Collection, $location, $routeParams) {
   $scope.collection = Collection.get({id: $routeParams.id})
   $scope.update = function(){
     if ($scope.collectionForm.$valid){
       Collection.update({id: $scope.collection.contractno},{contractno: $scope.collectionForm.contractno.$viewValue, kode_cabang: $scope.collectionForm.kode_cabang.$viewValue},function(){
         $location.path('/');
       }, function(error) {
         console.log(error)
      });
     }
   };
}]);

myApp.controller("CollectionListCtr", ['$scope', '$http', '$resource', 'Collections', 'Collection', '$location', function($scope, $http, $resource, Collections, Collection, $location) {
  $scope.collections = Collections.query();
  $scope.deleteCollection = function (collectionId) {
    if (confirm("Are you sure you want to delete this collection?")){
      Collection.delete({ id: collectionId }, function(){
        $scope.collections = Collections.query();   // after delete collection get collections collection.
        $location.path('/');
      });
    }
  };
}]);
