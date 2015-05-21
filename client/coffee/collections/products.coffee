angular
.module('Collection:Products', [
 # Dependencies
    'Util'
])
.factory 'CollectionProducts', (
 # Dependency Injections
    $rootScope
    Util
) ->

    class CollectionProducts
        constructor: () ->
            @all = {}

        get: (uid) ->
            @all[uid]

        set: (uid, product) ->
            @all[uid] = product

            @all[uid].click = ->
                mq = Util.mediaQuery.get()
                if mq is "0" or mq is "1"
                    window.location = @detailPageURL
                else
                    $rootScope.$broadcast 'product:detail', @product_id

            return @

        contains: (uid) ->
            @all[uid] isnt undefined



    CollectionProducts