function love.load()
  myShader = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
      vec2 normalized_screen_coords = vec2(screen_coords.x / love_ScreenSize.x, screen_coords.y / love_ScreenSize.y) - vec2(0.5, 0.5);
      vec4 pixel = Texel(texture, texture_coords );
      pixel *= step(0.4, length(normalized_screen_coords));
      return pixel * color;
    }
  ]]
end
function love.draw()
  love.graphics.setShader(myShader) --draw something here
  local width, height = love.graphics.getDimensions()
  love.graphics.rectangle("fill", 0, 0, width, height)
  love.graphics.setShader()
end
