-- The default track, which draws the incoming notes as dots along a guitar neck,
-- similar to many other games in this genre such as guitar hero, rock band, and
-- tap tap revolution.

return {
  track = nil,
  notes = nil,

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
  end,

  setTrack = function(this, track)
    this.track = track -- maybe should copy
    this.notes = {}
    this:updateNotes()
  end,

  update = function(this, dt)
    this:updateNotes()
  end,

  updateNotes = function(this)
    -- update cursor in track, clear old note objects, and create new note objects
  end,
}
