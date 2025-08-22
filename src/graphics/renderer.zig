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

// Make each renderer have the uniform values needed for their shader / compose a struct that is a union of all uniform types for shaders
// Shaders on-use can be passed their uniform struct (or do via some other way). Only set when value has changed?
// Maybe there is some other better way to pass uniform values?
// THere is instanced rendering, but for now just keep it simple with uniforms, then impliment that later
