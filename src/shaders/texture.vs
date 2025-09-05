#version 330 core

layout(location = 0) in vec2 inTex;
layout(location = 1) in vec2 inPos;

out vec2 texPos;

void main() {
    gl_Position = vec4(inPos.x, inPos.y, 0, 1.0);
    texPos = inTex;
}