require 'util'
local button = require 'menu.button'

return {
  create = function(combo, track)
    util.assert.table(combo)
    util.assert.table(track)

    return require('menu.menu').create({
      restart = button.create(love.graphics.getHeight() - 100, "PLAY AGAIN", function()
        game:startTrack(track)
      end),
      menu = button.create(love.graphics.getHeight() - 50, "GO TO MENU", function()
        game:goToTracksMenu()
      end),
    }, {
      combo = combo,

      headerFont = love.graphics.newFont(80),
      scoreFont = love.graphics.newFont(40),
      scoreLabelFont = love.graphics.newFont(20),

      draw = function(this)
        love.graphics.push()

        local currentFont = love.graphics.getFont()

        love.graphics.setFont(this.headerFont)
        if this.combo.perfect then
          love.graphics.setColor(0, 1, 0, 1)
          love.graphics.printf("PERFECT!", 0, 100, love.graphics.getWidth(), "center")
        else
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.printf("Nice!", 0, 100, love.graphics.getWidth(), "center")
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(this.scoreFont)
        love.graphics.printf(tostring(this.combo.hits)..'/'..tostring(this.combo.hits + this.combo.misses), 0, 250, love.graphics.getWidth(), "center")
        love.graphics.setFont(this.scoreLabelFont)
        love.graphics.printf("notes hit", 0, 300, love.graphics.getWidth(), "center")

        love.graphics.setFont(currentFont)
        love.graphics.pop()

        this:drawButtons()
      end,

      keypressed = function(this, key, scancode, isRepeat)
        if key == "escape" then
          game:goToTracksMenu()
        end
      end,
    })
  end
}
