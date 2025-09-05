#version 330 core

uniform sampler2D tex0;

in vec2 texPos;

out vec4 outFragColor;

void main() {
    vec4 color = texture(tex0, texPos);
    if (color.a == 0) discard;
    
    outFragColor = color;
}