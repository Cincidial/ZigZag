const gl = @import("zopengl").bindings;
const Shader = @import("shader.zig").Shader;

pub const Renderer = struct {
    shader: *const Shader,
    vao: gl.Uint,
    index_count: u16,

    pub fn init(shader: *const Shader, vao: gl.Uint, index_count: u16) Renderer {
        return .{ .shader = shader, .vao = vao, .index_count = index_count };
    }

    pub fn render(self: Renderer) void {
        self.shader.*.use();
        gl.bindVertexArray(self.vao);
        gl.drawElements(gl.TRIANGLES, self.index_count, gl.UNSIGNED_SHORT, null);
        gl.bindVertexArray(0);
    }
};
