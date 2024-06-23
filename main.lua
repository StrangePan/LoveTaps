
local game = {
  player = {},
}

function love.load()
  game.music = love.audio.newSource("tracks/hole-in-one-2.mp3", "stream")
  game.music:play()

  love.graphics.setBackgroundColor(1, 1, 1, 1)
  game.player.tapper = require 'player-tapper'
  game.track = require 'guitar-hero-track'
end

function love.update(dt)
  if game.track and game.track.update then
    game.track:update(dt)
  end
  if game.player.tapper and game.player.tapper.update then
    game.player.tapper:update(dt)
  end
end

function love.mousepressed(x, y, button, isTouch, presses)
  if game.player.tapper then
    game.player.tapper:tap()
  end
end

function love.keypressed(key, scancode, isRepeat)
  if key == "space" and not isRepeat then
    if game.player.tapper and game.player.tapper.tap then
      game.player.tapper:tap()
    end
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
