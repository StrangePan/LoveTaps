return {
  create = function(targetTime, speed, onDestroy)
    return {
      targetTime = targetTime,
      speed = speed,
      onDestroy = onDestroy,
      state = 0,

      draw = function(this)
        love.graphics.push()

        if this.state == 0 then
          love.graphics.setColor(love.math.colorFromBytes(255, 242, 60))
        elseif this.state == 1 then
          love.graphics.setColor(love.math.colorFromBytes(0, 221, 21))
        elseif this.state == 2 then
          love.graphics.setColor(love.math.colorFromBytes(255, 49, 76))
        end

        local height = 20
        local width = 100
        local offset = (love.timer.getTime() - this.targetTime) * this.speed
        love.graphics.rectangle(
            "fill",
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() - 100 - height / 2 + offset,
            width,
            height)

        love.graphics.pop()
      end,

      hit = function(this)
        this.state = 1
      end,

      miss = function(this)
        this.state = 2
      end,
    }
  end
}
