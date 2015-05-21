angular
.module('Util', [
# Dependencies
])
.factory 'Util', (
# Dependency Injections
    $rootScope
) ->
    Util = {}
    Util.mediaQuery = {}
        # Cache jQuery selection, whose `z-index` value describes current media query state
    Util.mediaQuery.$el = angular.element document.getElementById('media-query')
        # Query current media query state
    Util.mediaQuery.get = ->
        this.$el.css 'z-index'

    Util