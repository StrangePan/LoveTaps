return {
  create = function(x, y, action)
    local button = {
      x = x,
      y = y,
      action = action,

      width = 80,
      height = 80,

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
            this.x - this.width / 2,
            this.y - this.height / 2,
            this.width,
            this.height,
            8)

        local iconSize = this.width * 3.0 / 5.0
        local iconThickness = this.width / 5.0

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", this.x - iconSize / 2, this.y - iconSize / 2, iconThickness, iconSize)
        love.graphics.rectangle("fill", this.x + iconSize / 2 - iconThickness, this.y - iconSize / 2, iconThickness, iconSize)

        love.graphics.pop()
      end,

      mousemoved = function(this, x, y, dx, dy, istouch)
        this.hovered = this:collidesWith(x, y)
      end,

      mousepressed = function(this, x, y, button, isTouch, presses)
        this.pressed = this.hovered
        return this.hovered
      end,

      mousereleased = function(this, x, y, button, istouch, presses)
        if this.pressed and this.hovered then
          this.action()
        end
        local consume = this.pressed
        this.pressed = false
        return consume
      end,

      collidesWith = function(this, x, y)
        return (
            x >= this.x - this.width / 2
                and x <= this.x + this.width / 2
                and y >= this.y - this.height / 2
                and y <= this.y + this.height / 2)
      end,
    }
    button:init()
    return button
  end,
}
