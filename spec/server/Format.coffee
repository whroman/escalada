Format = require "./../../server/scripts/Format"

class Test
    constructor: (@i, @o) ->

tests = {}
tests.valid = [
    new Test 1, '0.01'
    new Test 10, '0.10'
    new Test 11, '0.11'
    new Test 100, '1.00'
    new Test 101, '1.01'
    new Test '1', '0.01'
    new Test '10', '0.10'
    new Test '100', '1.00'
    new Test '101', '1.01'
]

tests.invalid = [
    null
    undefined
    []
    {}
    Infinity
]

describe "Format", ->
    it ".price() should convert cent-base price values to include a decimal", ->
        for test in tests.valid
            expect Format.price(test.i)
                .toBe test.o

    it ".price() should throw an error if not given a String or Number", ->
        for test in tests.invalid
            expect( ->
                Format.price test
            ).toThrow()