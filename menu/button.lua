return {
  create = function(y, text, action)
    local button = {
      y = y,
      text = text,
      action = action,

      width = 200,
      height = 40,

      hovered = false,
      pressed = false,

      init = function(this)
        this.hovered = this:collidesWith(love.mouse.getPosition())
        return this
      end,

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
        this.hovered = this:collidesWith(x, y)
      end,

      mousepressed = function(this, x, y, button, isTouch, presses)
        this.pressed = this.hovered
      end,

      mousereleased = function(this, x, y, button, istouch, presses)
        if this.pressed and this.hovered then
          this.action()
        end
        this.pressed = false
      end,

      collidesWith = function(this, x, y)
        return (
            x >= (love.graphics.getWidth() - this.width) / 2
            and x <= (love.graphics.getWidth() + this.width) / 2
            and y >= this.y - this.height / 2
            and y <= this.y + this.height / 2)
      end,
    }
    button:init()
    return button
  end,
}
