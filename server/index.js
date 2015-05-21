// If file is not being executed from within /server, programmatically chdir into /server
(function() {
    var curDir = process.cwd().split('/').pop();
    if (curDir !== 'server') process.chdir('./server');
})();

// Third-party libs
var express = require('express');
var request = require('request');

// Custom scripts
var Product = require('./scripts/Product');
var Products = require('./scripts/Products');


// Bootstrap app
var app = express();
app.set('views', './views');
app.set('view engine', 'jade');
app.locals.pretty = true;
var port = 3000;
app.listen(port);
console.log('Now connected to port ' + port);

// Add paths for serving static content
(function() {
    function addStaticPath (path) {
        return express["static"](process.cwd() + path);
    };

    app.use("/client", addStaticPath('./../client'));
})();

function requestIsValid (err, res) {
    return (
        !err &&
        res.statusCode === 200
    );
}

app.get('/', function(req, res) {
    res.redirect('/list');
});

app.get('/list', function(req, res) {
    var scope;
    scope = {};
    var url = 'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list';
    request(url, function(error, response, body) {
        if (requestIsValid(error, response)) {
            body = JSON.parse(body);
            scope.PRODUCTS = (new Products(body.products)).all;
            res.render('pages/products-list', scope);
        }
    });
});

app.get('/list/:productId', function(req, res) {
    var scope;
    scope = {};
    var url = 'https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/' + req.params.productId + '/detail'
    request(url, function(error, response, body) {
        if (requestIsValid(error, response)) {
            body = JSON.parse(body);
            if (body.product_id === req.params.productId) {
                scope.PRODUCT = new Product(body);
                res.render('pages/product-detail', scope);
                return;
            }
        }
        res.redirect('/list');
    });
});