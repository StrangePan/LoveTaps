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

  --- A collection of assertions that can be used to reduce code duplication.
  assert = {

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
