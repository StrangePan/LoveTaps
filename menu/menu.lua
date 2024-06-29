require 'util'

return {
  create = function(buttons, additionalProperties)
    util.assert.table(buttons)
    util.assert.tableOrNil(additionalProperties)

    local menuBase = {
      buttons = buttons,

      draw = function(this)
        this:drawButtons()
      end,

      drawButtons = function(this)
        for _,button in pairs(this.buttons) do
          button:draw()
        end
      end,

      mousemoved = function(this, x, y, dx, dy, istouch)
        for _,button in pairs(this.buttons) do
          if button.mousemoved then
            button:mousemoved(x, y, dx, dy, istouch)
          end
        end
      end,

      mousepressed = function(this, x, y, button, isTouch, presses)
        for _,button in pairs(this.buttons) do
          if button.mousepressed then
            button:mousepressed(x, y, button, isTouch, presses)
          end
        end
      end,

      mousereleased = function(this, x, y, button, istouch, presses)
        for _,button in pairs(this.buttons) do
          if button.mousereleased then
            button:mousereleased(x, y, button, istouch, presses)
          end
        end
      end,
    }

    return util.table.merge(menuBase, additionalProperties)
  end
}
