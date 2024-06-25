
local game = {
}

local record = false
local recording = {}
local recordingFile = nil

local backgroundShader = nil

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
  local shaderContents,e = love.filesystem.read("shaders/background.glsl")
  if not shaderContents then error(e) end
  backgroundShader = love.graphics.newShader(shaderContents)

  if record then
    recordingFile = love.filesystem.newFile("recording")
    local ok,e = recordingFile:open('w')
    if not ok then error(e) end
  end

  love.graphics.setBackgroundColor(1, 1, 1, 1)

  game.music = love.audio.newSource("tracks/hole-in-one-2.mp3", "stream")

  game.track = require 'guitar-hero-track'
  game.track:setTrack(game.music, loadTrack("tracks/hole-in-one-2.track"))
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
end

local function tap()
  if record then
    table.insert(recording, game.music:tell())
  end
  if game.track then
    game.track:tap()
  end
end

function love.mousepressed(x, y, button, isTouch, presses)
  tap()
end

function love.keypressed(key, scancode, isRepeat)
  if key == "space" and not isRepeat then
    tap()
  end
  if key == "escape" and not isRepeat then
    if game.music then
      if game.music:isPlaying() then
        game.music:pause()
      else
        game.music:play()
      end
    end
  end
end

function love.draw()
  love.graphics.setShader(backgroundShader)
  love.graphics.setColor(love.math.colorFromBytes(110, 216, 255))
  backgroundShader:send('time', love.timer.getTime())
  backgroundShader:send('topColor', { love.math.colorFromBytes(63, 208, 196, 255) })
  backgroundShader:send('bottomColor', { love.math.colorFromBytes(153, 159, 208, 255) })
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setShader()

  if game.track and game.track.draw then
    game.track:draw()
  end
end
