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

    # Detail modal
    $scope.modal = {}
    $scope.modal.data = null
    $scope.modal.isLoading = false
    $scope.modal.isOpen = false
    $scope.modal.open = (productId) ->
        product = $scope.products.get productId
        console.log productId, product
        @isOpen = true
        @isLoading = true
        $http.get product.detailGetURL
            .success (data, status, headers, config) =>
                @data = data
                @isLoading = false
                console.log data

    $scope.modal.close = ->
        this.data = null
        this.isOpen = false

    $scope.$on 'product:detail', (event, productId) ->
        $scope.modal.open productId
