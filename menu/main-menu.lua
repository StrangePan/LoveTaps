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
      draw = function(this)
        this:drawButtons()

        love.graphics.setColor(1, 1, 1, 1)

        if game.logo then
          local scale = (300 / game.logo:getHeight()) * util.math.remap(-1, 1, 1, 1.2, math.sin(love.timer.getTime() / 5))
          love.graphics.draw(
              game.logo,
              love.graphics.getWidth() / 2,
              250,
              math.sin(love.timer.getTime() / 3) / 9,
              scale,
              scale,
              game.logo:getWidth() --[[/ game.logo:getDPIScale()--]] / 2,
              game.logo:getHeight() --[[/ game.logo:getDPIScale()--]] / 2)
        end

        love.graphics.printf(
            'Created by Dan Andrus for Pixelicious - http://www.danandrus.me       Music by Joystock - https://www.joystock.org',
            0,
            love.graphics.getHeight() - 20,
            love.graphics.getWidth(),
            'center')
      end,

      keypressed = function(this, key, scancode, isRepeat)
        if key == "escape" then
          game:quit()
        end
      end,
    })
  end
}
