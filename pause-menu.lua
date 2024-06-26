local button = {
  create = function(y, text, action)
    return {
      y = y,
      text = text,
      action = action,

      width = 200,
      height = 40,

      hovered = false,
      pressed = false,

      draw = function(this)
        love.graphics.push()

        if this.hovered then
          love.graphics.setColor(0.9, 0.9, 0.9, 1)
        else
          love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.rectangle(
            "fill",
            (love.graphics.getWidth() - this.width) / 2,
            this.y - this.height / 2,
            this.width,
            this.height,
            8)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(this.text,
            (love.graphics.getWidth() - this.width) / 2,
            this.y - this.height / 2 + 12,
            this.width,
            "center")

        love.graphics.pop()
      end,

      mousemoved = function(this, x, y, dx, dy, istouch)
        this.hovered =
            x >= (love.graphics.getWidth() - this.width) / 2
            and x <= (love.graphics.getWidth() + this.width) / 2
            and y >= this.y - this.height / 2
            and y <= this.y + this.height / 2
      end,

      mousepressed = function(this, x, y, button, isTouch, presses)
        this.pressed = this.hovered
      end,

      mousereleased = function(this, x, y, button, istouch, presses)
        if this.pressed and this.hovered then
          this.action()
        end
        this.pressed = false
      end
    }
  end,
}



local pauseMenu = {
  create = function()
    return {
      buttons = {
        continue = button.create((love.graphics.getHeight() - 120) / 2, "CONTINUE", function()
          game:unpause()
        end),
        restart = button.create((love.graphics.getHeight()) / 2, "RESTART", function()
          game:restart()
          game:unpause()
        end),
        quit = button.create((love.graphics.getHeight() + 120) / 2, "QUIT", function()
          game:quit()
        end)
      },

      draw = function(this)
        love.graphics.push()

        love.graphics.setColor(0, 0, 0, 0.2)
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

        for _,button in pairs(this.buttons) do
          button:draw()
        end

        love.graphics.pop()
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

      keypressed = function(this, key, scancode, isRepeat)
        if key == "escape" then
          game:unpause()
        end
      end
    }
  end,
}

return pauseMenu
