local button = require 'menu.button'

return {
  create = function()
    return require('menu.menu').create({
      tracks = button.create(love.graphics.getHeight() - 100, "TRACKS", function()
        game:goToTracksMenu()
      end),
      quit = button.create(love.graphics.getHeight() - 50, "QUIT", function()
        game:quit()
      end),
    }, {
      creditsFont = (function()
        local f = love.graphics.newFont(16)
        f:setLineHeight(1.4)
        return f
      end)(),

      draw = function(this)
        this:drawButtons()

        love.graphics.setColor(1, 1, 1, 1)

        if game.logo then
          local scale = (300 / game.logo:getHeight()) * util.math.remap(-1, 1, 1, 1.2, math.sin(love.timer.getTime() / 5))
          love.graphics.draw(
              game.logo,
              love.graphics.getWidth() / 2,
              225,
              math.sin(love.timer.getTime() / 3) / 9,
              scale,
              scale,
              game.logo:getWidth() --[[/ game.logo:getDPIScale()--]] / 2,
              game.logo:getHeight() --[[/ game.logo:getDPIScale()--]] / 2)
        end

        local font = love.graphics.getFont()
        love.graphics.setFont(this.creditsFont)
        love.graphics.printf(
            'Created by Dan Andrus for Pixelicious - http://www.danandrus.me\nMusic by Joystock - https://www.joystock.org',
            0,
            love.graphics.getHeight() - 180,
            love.graphics.getWidth(),
            'center')
        love.graphics.setFont(font)
      end,

      keypressed = function(this, key, scancode, isRepeat)
        if key == "escape" then
          game:quit()
        end
      end,
    })
  end
}
