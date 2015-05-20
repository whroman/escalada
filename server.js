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
            scope.PRODUCTS = body.products;
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
                scope.PRODUCT = body;
                res.render('detail', scope);
                return;
            }
        }
        res.redirect('/list');
    });
});