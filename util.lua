--- A collection of general-purpose utility functions that can be used to reduce code duplication.
util = {

  --- A collection of table-related functions that can be used to reduce code duplication.
  table = {

    --- Returns a new table that contains all of the key/value pairs of a and b.
    --- If any keys are equivalent in both table a and b, the key/value pair from b will
    --- take precedent over a.
    merge = function(a, b)
      util.assert.tableOrNil(a)
      util.assert.tableOrNil(b)

      local result = {}
      if a then
        for key,value in pairs(a) do
          result[key] = value
        end
      end
      if b then
        for key,value in pairs(b) do
          result[key] = value
        end
      end
      return result
    end,
  },

  --- A collection of math-related functions
  math = {

    --- Returns `from` if `ratio` is 0, `to` if `ratio` is 1.
    lerp = function(from, to, ratio)
      util.assert.number(ratio)
      if type(from) == 'number' then
        util.assert.number(to)
        return from + (to - from) * ratio
      elseif type(from) == 'table' then
        util.assert.table(to)
        local fromLength, toLength = #from, #to
        assert(fromLength == toLength, 'expected equal length, got '..tostring(fromLength)..' and '..tostring(toLength))
        local result = {}
        for i = 1,fromLength do
          result[i] = util.math.lerp(from[i], to[i], ratio)
        end
        return result
      end
    end,
  },

  --- A collection of assertions that can be used to reduce code duplication.
  assert = {

    --- Asserts that the given parameter is a number. Returns the number.
    number = function(a)
      assert(type(a) == 'number', 'number expected, got '..type(a))
      return a
    end,

    --- Asserts that the given parameter is either nil or an integer number greater than 0. Returns the number.
    positiveIntegerOrNil = function(a)
      assert(a == nil or type(a) == 'number' and math.type(a) == 'integer', 'nil or integer expected, got '..type(a))
      return a
    end,

    --- Asserts that the given parameter is a string. Returns the string.
    string = function(a)
      assert(type(a) == 'string', 'string expected, got '..type(a))
      return a
    end,

    --- Asserts that the given parameter is a table. Returns the table.
    table = function(a)
      assert(type(a) == 'table', 'table expected, got '..type(a))
      return a
    end,

    --- Asserts that the given parameter is either nil or a table. Returns the table.
    tableOrNil = function(a)
      assert(a == nil or type(a) == 'table', 'nil or table expected, got '..type(a))
      return a
    end,

    --- Asserts that the given parameter is a userdata. Returns the userdata.
    userdata = function(a)
      assert(type(a) == 'userdata', 'userdata expected, got '..type(a))
      return a
    end,
  },
}

return util
