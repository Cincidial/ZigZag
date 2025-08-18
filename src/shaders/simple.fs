#version 330 core

in vec4 vertexColor;
out vec4 outFragColor;

void main() {
    outFragColor = vertexColor;
}