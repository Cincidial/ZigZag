const Shader = @import("graphics/shader.zig").Shader;
const TextureRenderer = @import("graphics/renderer.zig").TextureRenderer;
const Vec2 = @import("math.zig").Vec2;

pub var run_app = true;

pub var window_w: u16 = 0;
pub var window_h: u16 = 0;
pub var window_dim: Vec2 = Vec2.ZERO;

pub var simple_shader: Shader = undefined;
pub var texture_shader: Shader = undefined;

pub fn init() !void {
    simple_shader = try Shader.init(@embedFile("shaders/simple.vs"), @embedFile("shaders/simple.fs"));

    texture_shader = try Shader.init(@embedFile("shaders/texture.vs"), @embedFile("shaders/texture.fs"));
    texture_shader.setInt("tex0", 0);
}

pub fn deinit() void {
    simple_shader.deinit();
    texture_shader.deinit();
}
