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

        set: (uid, product) ->
            @all[uid] = product

            @all[uid].click = ->
                mq = Util.mediaQuery.get()
                if mq is "0" or mq is "1"
                    window.location = '/list/' + @product_id
                else
                    # 

            return @

        contains: (uid) ->
            @all[uid] isnt undefined



    CollectionProducts