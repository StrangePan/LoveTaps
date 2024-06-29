local button = require 'menu.button'
local tracks = require 'tracks'

return {
  create = function(page)
    local tracksPerPage = 5
    local startTrack = (page - 1) * tracksPerPage + 1
    local heightPerButton = 60

    local function createTrackButton(trackIndex)
      local track = tracks[trackIndex]
      if not track then return nil end
      return button.create(
          love.graphics.getHeight() / 2
            - heightPerButton * 2.5
            + (trackIndex - startTrack) * heightPerButton,
          track.displayName,
          function()
            game:startTrack(track)
          end)
    end

    local buttons = {}
    for i = 1,tracksPerPage do
      buttons[i] = createTrackButton(startTrack + (i - 1))
    end

    if page + tracksPerPage <= #tracks then
      buttons.next = button.create(love.graphics.getHeight() - 50 - heightPerButton, "NEXT", function()
        game:goToTracksMenu(page + 1)
      end)
    end

    buttons.back = button.create(love.graphics.getHeight() - 50, "BACK", function()
      if page == 1 then
        game:goToMainMenu()
      else
        game:goToTracksMenu(page - 1)
      end
    end)

    return require('menu.menu').create(buttons)
  end
}
