angular
.module('Controller:ProductsList', [
    'Collection:Products'
    'Util'
])
.controller 'Controller:ProductsList', (
# Dependency Injections
    $scope
    $window
    $http
    CollectionProducts
    Util
) ->
    $scope.util = Util
    $scope.products = new CollectionProducts

    if $window.products
        for product in $window.products
            $scope.products.set product.product_id, product

    # Dev
    $window.logScope = ->
        $window.$scope = $scope
        console.log $scope