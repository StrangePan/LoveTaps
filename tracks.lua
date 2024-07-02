require 'util'

local function track(key, displayName, fileName)
  return {
    key = util.assert.string(key),
    displayName = util.assert.string(displayName),
    musicFileName = util.assert.string(fileName)..'.mp3',
    notesFileName = util.assert.string(fileName)..'.track',
  }
end

tracks = {
  track('funkMeBaby', 'Funk Me Baby', 'joystock-funk-me-baby'),
  track('popsicle', 'Popsicle', 'joystock-popsicle'),
  track('aura', 'Aura', 'joystock-aura'),
}

-- Allow indexing by name instead of only by integer
for _,t in ipairs(tracks) do
  tracks[t.key] = track
end

return tracks
