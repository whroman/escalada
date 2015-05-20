angular
.module('Collection:Products', [
 # Dependencies
])
.factory 'CollectionProducts', (
 # Dependency Injections
    $rootScope
) ->

    class CollectionProducts
        constructor: () ->
            @all = {}

        set: (uid, product) ->
            @all[uid] = product

            return @

        contains: (uid) ->
            @all[uid] isnt undefined



    CollectionProducts