angular
.module 'Controller:ProductsList', []
.controller 'Controller:ProductsList', (
# Dependency Injections
    $scope,
    $window
) ->
    $scope.test = 'success!'
    # Dev
    $window.logScope = ->
        $window.$scope = $scope
        console.log $scope