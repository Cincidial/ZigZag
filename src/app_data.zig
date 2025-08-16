const Shader = @import("graphics/shader.zig").Shader;
const Vec2 = @import("math.zig").Vec2;

pub var run_app = true;

pub var window_w: u16 = 0;
pub var window_h: u16 = 0;
pub var window_dim: Vec2 = Vec2.ZERO;

pub var simple_shader: Shader = undefined;

pub fn init() !void {
    simple_shader = try Shader.init(@embedFile("shaders/simple.vs"), @embedFile("shaders/simple.fs"));
}

pub fn deinit() void {
    simple_shader.deinit();
}
