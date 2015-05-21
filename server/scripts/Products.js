var Product = require('./Product.js');

var Products = (function() {
    var Products = function (datum) {
        this.all = [];

        datum.forEach(function(data) {
            this.all.push( new Product(data) );
        }.bind(this));
    }

    return Products;
})();

module.exports = Products;