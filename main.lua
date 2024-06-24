
local game = {
  player = {},
}

local record = false
local recording = {}
local recordingFile = nil

local function loadTrack(filename)
  local file = love.filesystem.newFile(filename)
  local ok,e = file:open('r')
  if not ok then error(e) end
  local track = {}
  for line in file:lines() do
    table.insert(track, tonumber(line))
  end
  file:close()
  return track
end

function love.load()
  if record then
    recordingFile = love.filesystem.newFile("recording")
    local ok,e = recordingFile:open('w')
    if not ok then error(e) end
  end

  love.graphics.setBackgroundColor(1, 1, 1, 1)
  game.player.tapper = require 'player-tapper'
  game.track = require 'guitar-hero-track'
  game.track:setTrack(loadTrack("tracks/hole-in-one-2.track"))

  game.music = love.audio.newSource("tracks/hole-in-one-2.mp3", "stream")
  game.startTime = love.timer.getTime()
  game.music:play()
end

function love.quit()
  if record then
    for _,t in ipairs(recording) do
      recordingFile:write(tostring(t)..'\n')
    end
    recordingFile:close()
  end
  return false
end

function love.update(dt)
  if game.track and game.track.update then
    game.track:update(dt)
  end
  if game.player.tapper and game.player.tapper.update then
    game.player.tapper:update(dt)
  end
end

local function tap()
  if record then
    table.insert(recording, love.timer.getTime() - game.startTime)
  end
  if game.player.tapper then
    game.player.tapper:tap()
  end
end

function love.mousepressed(x, y, button, isTouch, presses)
  tap()
end

function love.keypressed(key, scancode, isRepeat)
  if key == "space" and not isRepeat then
    tap()
  end
end

function love.draw()
  if game.track and game.track.draw then
    game.track:draw()
  end
  if game.player.tapper and game.player.tapper.draw then
    game.player.tapper:draw()
  end
end
