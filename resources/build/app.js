(function(){angular.module("app",["Controller:ProductsList"])}).call(this);
(function(){angular.module("Controller:ProductsList",[]).controller("Controller:ProductsList",function($scope,$window){return $scope.test="success!",$window.logScope=function(){return $window.$scope=$scope,console.log($scope)}})}).call(this);
//# sourceMappingURL=maps/app.js.map