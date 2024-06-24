-- The default track, which draws the incoming notes as dots along a guitar neck,
-- similar to many other games in this genre such as guitar hero, rock band, and
-- tap tap revolution.

local note = require 'guitar-hero-note'

return {
  track = nil,
  notes = nil,
  startTime = love.timer.getTime(),

  draw = function(this)
    love.graphics.push()

    local centerX = love.graphics.getWidth() / 2
    local top = 0
    local bottom = love.graphics.getHeight()
    local width = 240
    local thickness = 4

    love.graphics.setColor(0.75, 0.75, 0.75, 1)
    love.graphics.rectangle("fill", centerX - width / 2, bottom - 101, width, 2)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", centerX - width / 2 - thickness / 2, top, thickness, bottom - top)
    love.graphics.rectangle("fill", centerX + width / 2 - thickness / 2, top, thickness, bottom - top)

    love.graphics.pop()

    if this.notes then
      for i,n in ipairs(this.notes) do
        n:draw()
      end
    end
  end,

  setTrack = function(this, track)
    this.track = track -- maybe should copy
    this.notes = {}
    this.trackIndex = 1
    this:updateNotes()
  end,

  update = function(this, dt)
    if not this.track or not this.notes then
      return
    end
    this:updateNotes()
  end,

  updateNotes = function(this)
    local time = love.timer.getTime() - this.startTime
    while #this.notes > 0 and this.notes[1].targetTime < time - 1 do
      table.remove(this.notes, 1)
    end
    while this.trackIndex <= #this.track
        and this.track[this.trackIndex] < (time - this.startTime + 6) do
      table.insert(this.notes, note.create(this.track[this.trackIndex], 300))
      this.trackIndex = this.trackIndex + 1
    end
  end,
}
