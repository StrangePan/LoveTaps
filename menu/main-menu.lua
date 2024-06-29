local button = require 'menu.button'

return {
  create = function()
    return require('menu.menu').create({
      tracks = button.create(love.graphics.getHeight() / 2, "TRACKS", function()
        game:goToTracksMenu()
      end),
      quit = button.create(love.graphics.getHeight() - 50, "QUIT", function()
        game:quit()
      end),
    })
  end
}
