return {
  create = function(targetTime, speed)
    return {
      targetTime = targetTime,
      speed = speed,
      state = 0,

      draw = function(this, time)
        love.graphics.push()

        if this.state == 0 then
          love.graphics.setColor(love.math.colorFromBytes(255, 242, 60))
        elseif this.state == 1 then
          love.graphics.setColor(love.math.colorFromBytes(0, 221, 21))
          love.graphics.pop()
          return
        elseif this.state == 2 then
          love.graphics.setColor(love.math.colorFromBytes(255, 49, 76))
        end

        local height = 20
        local width = 100
        love.graphics.rectangle(
            "fill",
            love.graphics.getWidth() / 2 - width / 2,
            this:getY(time) - height / 2,
            width,
            height,
            8)

        love.graphics.pop()
      end,

      getY = function(this, time)
        return love.graphics.getHeight() - 100 + (time - this.targetTime) * this.speed
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
