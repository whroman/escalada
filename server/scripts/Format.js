var Format = {};
Format.price = function (price) {
    var isString = typeof price === 'string';
    var isNum = Number.isInteger(price);

    if (!isString && !isNum) throw ".price(arg) - `arg` must be String or Number";

    if (isString) price = parseFloat(price);

    price = String(price / 100);

    if (price.indexOf('.') > -1) {
        var cents = price.split('.')[1];
        if (cents && cents.length === 1) price += '0';
    } else {
        price += '.00'
    }

    return price;
};

module.exports = Format;