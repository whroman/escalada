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
    class Products extends CollectionProducts
        constructor: () ->
            super
            @ajax = {}
            @ajax.isLoading = false
            @ajax.load = (url) =>
                @ajax.isLoading = true
                $http.get url
                    .success (data) =>
                        for product in data.products
                            @set product.product_id, product
                        @ajax.isLoading = false
                        console.log(this)
                    .error (data) =>
                        @ajax.isLoading = false

    $scope.products = new Products

    $scope.products.ajax.load 'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list'

    # Dev
    $window.logScope = ->
        $window.$scope = $scope
        console.log $scope