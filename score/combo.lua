require 'util'

return {
  create = function(x, y)
    return {
      -- drawing
      x = x,
      y = y,

      -- state
      perfect = true,
      streak = 0,

      -- stats
      hits = 0,
      misses = 0,

      font = love.graphics.newFont(160),

      hit = function(this)
        this.streak = this.streak + 1
        this.hits = this.hits + 1
      end,

      whiff = function(this)
        this.perfect = false
        this.streak = 0
      end,

      miss = function(this)
        this.perfect = false
        this.streak = 0
        this.misses = this.misses + 1
      end,

      draw = function(this)
        love.graphics.push()

        local colorMin = { 1, 1, 1, 1 }
        local colorMax = { 0, 1, 0, 1 }
        local colorRatio = math.min(this.streak / 20, 1)
        local color = util.math.lerp(colorMin, colorMax, colorRatio)

        local scaleMin = 0.5
        local scaleMax = 1
        local scale = util.math.lerp(scaleMin, scaleMax, colorRatio)

        local currentFont = love.graphics.getFont()

        local comboDigits = math.ceil(math.log(this.streak + 1, 10))
        local spacePerDigit = 80

        love.graphics.setFont(this.font)
        love.graphics.setColor(color)
        love.graphics.translate(x, y - (colorRatio * 40))
        love.graphics.scale(scale)
        love.graphics.scale(math.min(1, 160 / (comboDigits * spacePerDigit)), 1)
        love.graphics.print(tostring(this.streak))

        love.graphics.setFont(currentFont)

        -- TODO draw the "go for perfect!" prompt

        love.graphics.pop()
      end,
    }
  end
}
