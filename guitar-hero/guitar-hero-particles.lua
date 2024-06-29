return {
  create = function()
    return {
      tapSystem = (function()
        local dot = love.graphics.newCanvas(10, 10)
        love.graphics.push()
        love.graphics.setCanvas(dot)
        love.graphics.clear(1, 1, 1, 0)
        love.graphics.setColor(1, 1, 1, 1)
        --love.graphics.setColor(love.math.colorFromBytes(209, 53, 94, 255))
        --love.graphics.setColor(love.math.colorFromBytes(255, 127, 248, 255))
        love.graphics.circle("fill", 5, 5, 3)
        love.graphics.setCanvas()
        love.graphics.pop()

        local ps = love.graphics.newParticleSystem(dot, 128)
        ps:setParticleLifetime(0.3)
        ps:setRotation(0)
        ps:setSpread(math.pi / 2)
        ps:setLinearDamping(1)
        ps:setSpeed(50, 400)
        ps:setColors(
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 0)
        ps:setSizeVariation(1)
        return ps
      end)(),

      noteBreakSystem = (function()
        local box = love.graphics.newCanvas(10, 10)
        love.graphics.push()
        love.graphics.setCanvas(box)
        love.graphics.clear(1, 1, 1, 0)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("fill", 0, 0, 10, 10)
        love.graphics.setCanvas()
        love.graphics.pop()

        local ps = love.graphics.newParticleSystem(box, 200)
        ps:setParticleLifetime(1)
        ps:setRotation(0)
        ps:setSpread(math.pi / 8)
        ps:setLinearDamping(0)
        ps:setLinearAcceleration(0, 500)
        ps:setSpeed(300)
        ps:setColors(
            1, 0.9490196078, 0.2352941176, 1,
            0, 0.8666666667, 0.08235294118, 1,
            0, 0.8666666667, 0.08235294118, 1,
            0, 0.8666666667, 0.08235294118, 1)
        ps:setSizeVariation(1)
        ps:setEmissionArea("uniform", 50, 20)
        return ps
      end)(),

      update = function(this, dt)
        this.tapSystem:update(dt)
        this.noteBreakSystem:update(dt)
      end,

      draw = function(this)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(this.tapSystem, 0, 0)
        love.graphics.draw(this.noteBreakSystem, 0, 0)
      end,

      leftBurst = function(this)
        this:burst(-120, math.pi)
      end,

      rightBurst = function(this)
        this:burst(120, 0)
      end,

      burst = function(this, xOffset, direction)
        this.tapSystem:moveTo(love.graphics.getWidth() / 2 + xOffset, love.graphics.getHeight() - 100)
        this.tapSystem:setDirection(direction)
        this.tapSystem:emit(20)
      end,

      leftNoteBreak = function(this, y)
        this:noteBreak(y, math.pi * 0.6)
      end,

      rightNoteBreak = function(this, y)
        this:noteBreak(y, math.pi * 0.4)
      end,

      noteBreak = function(this, y, direction)
        this.noteBreakSystem:moveTo(love.graphics.getWidth() / 2, y)
        this.noteBreakSystem:setDirection(direction)
        this.noteBreakSystem:emit(60)
      end,
    }
  end,
}
