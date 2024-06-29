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
      for key,value in pairs(a) do
        result[key] = value
      end
      for key,value in pairs(b) do
        result[key] = value
      end
      return result
    end,
  },

  --- A collection of assertions that can be used to reduce code duplication.
  assert = {
    --- Checks that the given parameter is a table. Returns the table.
    table = function(a)
      assert(type(a) == "table")
      return a
    end,

    --- Checks that the given parameter is either nil or a table. Returns the table.
    tableOrNil = function(a)
      assert(a == nil or type(a) == "table")
      return a
    end,
  },
}

return util
