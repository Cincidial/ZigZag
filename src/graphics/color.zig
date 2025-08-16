const gl = @import("zopengl").bindings;

pub const Color = packed struct {
    pub const STRIDE = @sizeOf(f32) * 4;

    r: f32,
    g: f32,
    b: f32,
    a: f32,

    pub fn init(r: f32, g: f32, b: f32, a: f32) Color {
        return .{ .r = r, .g = g, .b = b, .a = a };
    }

    pub fn setupVaoAttrib(attrib: u8, stride: u16, offset: u16) void {
        gl.vertexAttribPointer(attrib, 4, gl.FLOAT, gl.FALSE, stride, @ptrFromInt(offset));
        gl.enableVertexAttribArray(attrib);
    }
};
