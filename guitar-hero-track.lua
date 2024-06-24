-- The default track, which draws the incoming notes as dots along a guitar neck,
-- similar to many other games in this genre such as guitar hero, rock band, and
-- tap tap revolution.

local note = require 'guitar-hero-note'

local hitTolerance = 0.1

return {
  track = nil,
  notes = nil,
  startTime = love.timer.getTime(),
  tapper = require 'guitar-hero-tapper',

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

    this.tapper:draw()
  end,

  tap = function(this)
    local tapTime = love.timer.getTime()
    this.tapper:tap()

    if this.track
        and this.trackIndex
        and this.trackIndex >= 1
        and this.notes
        and this.noteIndex then
      if this.noteIndex > 1
          and this.notes[this.noteIndex - 1].state == 0
          and this.notes[this.noteIndex - 1].targetTime + hitTolerance >= tapTime then
        this.notes[this.noteIndex - 1]:hit()
      elseif this.notes[this.noteIndex].state == 0
          and this.notes[this.noteIndex].targetTime - hitTolerance <= tapTime then
        this.notes[this.noteIndex]:hit()
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
    if this.track and this.notes then
      this:updateNotes()
    end
  end,

  updateNotes = function(this)
    local time = love.timer.getTime()
    while #this.notes > 0 and this.notes[1].targetTime + 1 < time do
      table.remove(this.notes, 1)
      if this.noteIndex then
        this.noteIndex = this.noteIndex - 1
        if this.noteIndex == 0 then
          this.noteIndex = nil
        end
      end
    end
    while this.trackIndex <= #this.track
        and this.startTime + this.track[this.trackIndex] < (time + 6) do
      table.insert(this.notes, note.create(this.startTime + this.track[this.trackIndex], 300))
      this.trackIndex = this.trackIndex + 1
      if not this.noteIndex then
        this.noteIndex = 1
      end
    end
    if this.noteIndex and this.notes then
      while this.noteIndex >= 1
          and this.noteIndex <= #this.notes
          and this.notes[this.noteIndex].targetTime < time do
        this.noteIndex = this.noteIndex + 1
      end
    end
    for i = 1,math.min(this.noteIndex, #this.notes) do
      if this.notes[i].state == 0
          and (i < this.noteIndex - 1
              or this.notes[i].targetTime + hitTolerance < time) then
        this.notes[i]:miss()
      end
    end
  end,
}
