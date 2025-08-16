const std = @import("std");
const glfw = @import("zglfw");
const zopengl = @import("zopengl");
const gl = zopengl.bindings;
const app = @import("app.zig");
const app_data = @import("app_data.zig");

const gl_version_major: u16 = 3;
const gl_version_minor: u16 = 3;

pub fn main() !void {
    try glfw.init();
    defer glfw.terminate();

    glfw.windowHint(.client_api, .opengl_api);
    glfw.windowHint(.context_version_major, gl_version_major);
    glfw.windowHint(.context_version_minor, gl_version_minor);
    glfw.windowHint(.opengl_profile, .opengl_core_profile);
    glfw.windowHint(.doublebuffer, true);

    const window = try glfw.Window.create(600, 600, "ZigZag", null);
    defer window.destroy();
    glfw.makeContextCurrent(window);
    glfw.swapInterval(1);

    try zopengl.loadCoreProfile(glfw.getProcAddress, gl_version_major, gl_version_minor);

    try app_data.init();
    defer app_data.deinit();

    app.init();
    defer app.deinit();
    _ = window.setFramebufferSizeCallback(app.windowResize);
    _ = window.setKeyCallback(app.keyEvent);

    while (!window.shouldClose() and app_data.run_app) {
        window.swapBuffers();
        glfw.pollEvents();

        gl.clearColor(0.12, 0.24, 0.36, 1.0);
        gl.clear(gl.COLOR_BUFFER_BIT);

        app.iterate();
    }

    try std.io.getStdOut().writeAll("Window Closed!\n");
}
