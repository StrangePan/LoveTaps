local button = require 'menu.button'

return {
  create = function()
    return require('menu.menu').create({
      continue = button.create((love.graphics.getHeight() - 120) / 2, "CONTINUE", function()
        game:unpause()
      end),
      restart = button.create((love.graphics.getHeight()) / 2, "RESTART", function()
        game:restart()
        game:unpause()
      end),
      quit = button.create((love.graphics.getHeight() + 120) / 2, "QUIT TO MENU", function()
        game:goToMainMenu()
      end),
    }, {
      draw = function(this)
        love.graphics.push()

        love.graphics.setColor(0, 0, 0, 0.3)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

        local width = 200
        local height = 200
        local padding = 20
        local rounding = 10

        love.graphics.setColor(love.math.colorFromBytes(20, 20, 200, 255))
        love.graphics.rectangle(
            "fill",
            (love.graphics.getWidth() - width) / 2 - padding,
            (love.graphics.getHeight() - height) / 2 - padding,
            width + padding * 2,
            height + padding * 2,
            rounding)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setLineWidth(8)
        love.graphics.rectangle(
            "line",
            (love.graphics.getWidth() - width) / 2 - padding,
            (love.graphics.getHeight() - height) / 2 - padding,
            width + padding * 2,
            height + padding * 2,
            rounding)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle(
            "line",
            (love.graphics.getWidth() - width) / 2 - padding,
            (love.graphics.getHeight() - height) / 2 - padding,
            width + padding * 2,
            height + padding * 2,
            rounding)

        this:drawButtons()

        love.graphics.pop()
      end,
    })
  end,
}
