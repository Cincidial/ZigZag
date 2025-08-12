const std = @import("std");
const glfw = @import("zglfw");
const gl = @import("zopengl").bindings;
const app_data = @import("app_data.zig");
const Mode = @import("game/mode.zig").Mode;
const Home = @import("game/home.zig");

var buffer: [1024 * 1024 * 5]u8 = undefined;
var alloc = std.heap.FixedBufferAllocator.init(&buffer);
var current_mode: Mode = undefined;

pub fn init() void {
    current_mode = .{ .home = Home.init(alloc.allocator()) };
}

pub fn deinit() void {
    current_mode.deinit();
}

pub fn windowResize(_: *glfw.Window, width: c_int, height: c_int) callconv(.c) void {
    app_data.window_w = @intCast(width);
    app_data.window_h = @intCast(height);
    app_data.window_dim = .{ .x = @floatFromInt(app_data.window_w), .y = @floatFromInt(app_data.window_h) };

    gl.viewport(0, 0, width, height);
}

pub fn keyEvent(_: *glfw.Window, key: glfw.Key, _: c_int, _: glfw.Action, _: glfw.Mods) callconv(.c) void {
    switch (key) {
        glfw.Key.escape => app_data.run_app = false,
        else => return,
    }
}

pub fn iterate() void {
    current_mode.iterate();
}
