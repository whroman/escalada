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
    return res.redirect('/list');
});

app.get('/list', function(req, res) {
    var scope;
    scope = {};
    return request('https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list', function(error, response, body) {
        if (!error && response.statusCode === 200) {
            body = JSON.parse(body);
            scope.PRODUCTS = body.products;
            return res.render('list', scope);
        }
    });
});