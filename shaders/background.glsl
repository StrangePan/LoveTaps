#pragma language glsl3

uniform float time;
uniform vec4 topColor;
uniform vec4 bottomColor;

vec4 effect(vec4 color, sampler2D t, vec2 texture_coords, vec2 screen_coords) {

    float s = love_ScreenSize.y / 600.0;

    vec4 pixel = texture(t, texture_coords);
    vec4 tint = vec4(1.0, 1.0, 1.0, 1.0);
    if (screen_coords.y < sin((screen_coords.x + time * 20.0) / 20.0) * 15.0 + 100.0 * s) {
        tint = topColor;
    } else if (screen_coords.y < sin((screen_coords.x + 20.0 - time * 20.0) / 20.0) * 15.0 + 200.0 * s) {
        tint = mix(topColor, bottomColor, 0.2);
    } else if (screen_coords.y < sin((screen_coords.x + 60.0 + time * 20.0) / 20.0) * 15.0 + 300.0 * s) {
        tint = mix(topColor, bottomColor, 0.4);
    } else if (screen_coords.y < sin((screen_coords.x + 90.0 - time * 20.0) / 20.0) * 15.0 + 400.0 * s) {
        tint = mix(topColor, bottomColor, 0.6);
    } else if (screen_coords.y < sin((screen_coords.x + 50.0 + time * 20.0) / 20.0) * 15.0 + 500.0 * s) {
        tint*= mix(topColor, bottomColor, 0.8);
    } else {
        tint = bottomColor;
    }
    return pixel * (tint * color);
}
