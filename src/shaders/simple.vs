#version 330 core

layout(location = 0) in vec4 inColor;
layout(location = 1) in vec2 inPos;

out vec4 vertexColor;

void main() {
    gl_Position = vec4(inPos.x, inPos.y, 0, 1.0);
    vertexColor = inColor;
}