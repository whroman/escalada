var express = require('express');
var request = require('request');

var port = 3000;

var addStaticPath = function(path) {
    return express["static"](process.cwd() + path);
};

app = express();

app.use("/resources", addStaticPath('/resources'));

app.set('views', './views');

app.set('view engine', 'jade');

app.locals.pretty = true;

app.listen(port);

console.log('Now connected to port ' + port);

var Products = {};
Products.formatPrice = function (products) {
    if (products.length == undefined) {
        products.price = (parseFloat(products.price) / 100).toString();
        var cents = products.price.split('.')[1];
        if (cents && cents.length === 1) {
            products.price = products.price + '0';
        }
    } else {
        products.forEach(function(product, index) {
            products[index] = this.format(product);
        }.bind(this));
    }
    return products;
};


app.get('/', function(req, res) {
    res.redirect('/list');
});

app.get('/list', function(req, res) {
    var scope;
    scope = {};
    var url = 'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list';
    request(url, function(error, response, body) {
        if (!error && response.statusCode === 200) {
            body = JSON.parse(body);
            scope.PRODUCTS = Products.formatPrice(body.products);
            res.render('list', scope);
        }
    });
});

app.get('/list/:productId', function(req, res) {
    var scope;
    scope = {};
    var url = 'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/' + req.params.productId + '/detail'
    request(url, function(error, response, body) {
        var requestWasValid = (
            !error &&
            response.statusCode === 200
        );

        if (requestWasValid) {
            body = JSON.parse(body);
            if (body.product_id === req.params.productId) {
                scope.PRODUCT = Products.formatPrice(body);
                res.render('detail', scope);
                return;
            }
        }
        res.redirect('/list');
    });
});