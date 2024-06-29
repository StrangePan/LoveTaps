return {
  create = function()
    return {
      x = love.graphics.getWidth() / 2,
      y = love.graphics.getHeight() - 100,
      side = 0,
      lastTapTime = nil,

      tap = function(this)
        if this.side == 0 then
          this.side = 1
        else
          this.side = 0
        end
        this.lastTapTime = love.timer.getTime()
      end,

      draw = function(this)
        love.graphics.push()

        local timeSinceTap = this.lastTapTime and love.timer.getTime() - this.lastTapTime or nil
        local tapSnap = 0.025
        local tapTrail = 0.1

        local fromX = this.x + (this.side == 0 and 120 or -120)
        local toX = this.x + (this.side == 0 and -120 or 120)

        if timeSinceTap and timeSinceTap < tapSnap then
          local x = fromX + (toX - fromX) * (timeSinceTap / tapSnap)
          --love.graphics.setColor(love.math.colorFromBytes(209,  53, 94, 255 * (1.0 - timeSinceTap / tapTrail)))
          love.graphics.setColor(1, 1, 1, (1.0 - timeSinceTap / tapTrail))
          love.graphics.rectangle("fill", math.min(fromX, x), this.y - 4, math.abs(x - fromX), 8)
          --love.graphics.setColor(love.math.colorFromBytes(209,  53, 94))
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.ellipse("fill", x, this.y, 20, 10)
        else
          if timeSinceTap and timeSinceTap < tapTrail then
            --love.graphics.setColor(love.math.colorFromBytes(209,  53, 94, 255 * (1.0 - timeSinceTap / tapTrail)))
            love.graphics.setColor(1, 1, 1, (1.0 - timeSinceTap / tapTrail))
            love.graphics.rectangle("fill", this.x - 120, this.y - 4, 240, 8)
          end
          --love.graphics.setColor(love.math.colorFromBytes(209,  53, 94))
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.circle("fill", toX, this.y, 10)
        end

        love.graphics.pop()
      end,
    }
  end,
}
