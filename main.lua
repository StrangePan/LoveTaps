require 'tracks'
require 'util'

game = {}

local record = false
local recording = {}
local recordingFile = nil

local backgroundShader = nil
local pauseMenu = require 'menu.pause-menu'

local function loadNotes(filename)
  local file = love.filesystem.newFile(filename)
  local ok,e = file:open('r')
  if not ok then error(e) end
  local notes = {}
  for line in file:lines() do
    table.insert(notes, tonumber(line))
  end
  file:close()
  return notes
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

  game:goToMainMenu()
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
  if game.menu and game.menu.update then
    game.menu:update(dt)
    return
  end
  if game.track and game.track.update then
    game.track:update(dt)
  end
end

local function tap()
  if game.menu then
    return
  end
  if record then
    table.insert(recording, game.music:tell())
  end
  if game.track then
    game.track:tap()
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  if game.menu and game.menu.mousemoved then
    game.menu:mousemoved(x, y, dx, dy, istouch)
    return
  end
end

function love.mousepressed(x, y, button, isTouch, presses)
  if game.menu and game.menu.mousepressed then
    game.menu:mousepressed(x, y, button, isTouch, presses)
    return
  end
  tap()
end

function love.mousereleased(x, y, button, istouch, presses)
  if game.menu and game.menu.mousereleased then
    game.menu:mousereleased(x, y, button, istouch, presses)
    return
  end
end

function love.wheelmoved(x, y)
  if game.menu and game.menu.wheelmoved then
    game.menu:wheelmoved(x, y)
    return
  end
end

local function closeCurrentTrack(this)
  this.track = nil
  if this.music then
    this.music:stop()
    this.music = nil
  end
  this.currentTrack = nil
end

local function showMenu(this, menu)
  this.menu = menu
end

function game.goToMainMenu(this)
  closeCurrentTrack(this)
  showMenu(this, require('menu.main-menu').create())
end

function game.goToTracksMenu(this, page)
  page = util.assert.positiveIntegerOrNil(page) or 1
  closeCurrentTrack(this)
  showMenu(this, require('menu.tracks-menu').create(page))
end

function game.startTrack(this, track)
  util.assert.table(track)
  util.assert.string(track.musicFileName)
  util.assert.string(track.notesFileName)

  this.menu = nil

  closeCurrentTrack(this)

  this.currentTrack = track
  this.music = love.audio.newSource("tracks/"..track.musicFileName, "stream")
  this.track = require 'guitar-hero.guitar-hero-track'.create()
  this.track:setNotes(this.music, loadNotes("tracks/"..track.notesFileName))
  this.music:play()
end

function game.pause(this)
  if not this.menu then
    this.menu = pauseMenu.create()
  end
  if this.music then
    this.music:pause()
  end
end

function game.unpause(this)
  this.menu = nil
  if this.music then
    this.music:play()
  end
end

function game.restart(this)
  if not this.currentTrack or not this.music or not this.track then return end
  local notes = this.track.track
  this.music:pause()
  this.music:seek(0)
  this.track = require 'guitar-hero.guitar-hero-track'.create()
  this.track:setNotes(this.music, notes)
  this.music:play()
end

function game.quit(this)
  love.event.quit()
end

function love.keypressed(key, scancode, isRepeat)
  if game.menu and game.menu.keypressed then
    game.menu:keypressed(key, scancode, isRepeat)
    return
  end
  if key == "space" and not isRepeat then
    tap()
  end
  if key == "escape" and not isRepeat then
    game:pause()
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

  if game.menu then
    game.menu:draw()
  end
end
