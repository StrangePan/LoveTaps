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
