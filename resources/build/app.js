(function(){angular.module("Util",[]).factory("Util",function($rootScope){var Util;return Util={},Util.mediaQuery={},Util.mediaQuery.$el=angular.element(document.getElementById("media-query")),Util.mediaQuery.get=function(){return this.$el.css("z-index")},Util})}).call(this);
(function(){angular.module("App:List",["Controller:ProductsList","Util"])}).call(this);
(function(){angular.module("Collection:Products",["Util"]).factory("CollectionProducts",function($rootScope,Util){var CollectionProducts;return CollectionProducts=function(){function CollectionProducts(){this.all={}}return CollectionProducts.prototype.set=function(uid,product){return this.all[uid]=product,this.all[uid].click=function(){var mq;return mq=Util.mediaQuery.get(),"0"===mq||"1"===mq?window.location="/list/"+this.product_id:void 0},this},CollectionProducts.prototype.contains=function(uid){return void 0!==this.all[uid]},CollectionProducts}()})}).call(this);
(function(){angular.module("Controller:ProductsList",["Collection:Products","Util"]).controller("Controller:ProductsList",function($scope,$window,$http,CollectionProducts,Util){var i,len,product,ref;if($scope.util=Util,$scope.products=new CollectionProducts,$window.products)for(ref=$window.products,i=0,len=ref.length;len>i;i++)product=ref[i],$scope.products.set(product.product_id,product);return $window.logScope=function(){return $window.$scope=$scope,console.log($scope)}})}).call(this);
//# sourceMappingURL=maps/app.js.map