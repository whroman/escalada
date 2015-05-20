angular
.module('Controller:ProductsList', [
    'Collection:Products'
])
.controller 'Controller:ProductsList', (
# Dependency Injections
    $scope
    $window
    $http
    CollectionProducts
) ->
    $scope.products = new CollectionProducts

    if $window.products
        for product in $window.products
            $scope.products.set product.product_id, product

    # Dev
    $window.logScope = ->
        $window.$scope = $scope
        console.log $scope