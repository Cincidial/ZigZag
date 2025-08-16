#version 330 core

layout(location = 0) in vec4 color;
layout(location = 1) in vec2 pos;

void main() {
    gl_Position = vec4(pos.x, pos.y, 0, 1.0);
}