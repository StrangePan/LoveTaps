#pragma language glsl3

uniform float time;
uniform vec4 topColor;
uniform vec4 bottomColor;

vec4 effect(vec4 color, sampler2D t, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = texture(t, texture_coords);
    vec4 tint = vec4(1.0, 1.0, 1.0, 1.0);
    if (screen_coords.y < sin((screen_coords.x + time * 20) / 20) * 15 + 100) {
        tint = topColor;
    } else if (screen_coords.y < sin((screen_coords.x + 20 - time * 20) / 20) * 15 + 200) {
        tint = mix(topColor, bottomColor, 0.2);
    } else if (screen_coords.y < sin((screen_coords.x + 60 + time * 20) / 20) * 15 + 300) {
        tint = mix(topColor, bottomColor, 0.4);
    } else if (screen_coords.y < sin((screen_coords.x + 90 - time * 20) / 20) * 15 + 400) {
        tint = mix(topColor, bottomColor, 0.6);
    } else if (screen_coords.y < sin((screen_coords.x + 50 + time * 20) / 20) * 15 + 500) {
        tint*= mix(topColor, bottomColor, 0.8);
    } else {
        tint = bottomColor;
    }
    return pixel * (tint * color);
}
