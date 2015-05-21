var Format = require('./Format.js');

var Product = (function() {
    var Product = function (data) {
        this.product_id = data.product_id;
        this.name = data.name;
        this.price = Format.price(data.price);
        this.image = data.image;
        this.detailGetURL = [
            'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/',
            this.product_id,
            '/detail'
        ].join('');
        this.detailPageURL = [
            '/list/',
            this.product_id
        ].join('');
    }

    return Product;
})();

module.exports = Product;