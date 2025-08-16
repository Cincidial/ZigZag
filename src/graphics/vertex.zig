const gl = @import("zopengl").bindings;
const std = @import("std");
const Allocator = @import("std").mem.Allocator;
const Color = @import("color.zig").Color;
const Vec2 = @import("../math.zig").Vec2;
const graphics_mem = @import("memory.zig");

pub const ColorVertex = packed struct {
    color: Color,
    pos: Vec2,

    pub fn init(color: Color, pos: Vec2) ColorVertex {
        return .{
            .color = color,
            .pos = pos,
        };
    }

    pub fn genVao(slice: []const ColorVertex) gl.Uint {
        var vao: gl.Uint = undefined;
        gl.genVertexArrays(1, &vao);

        gl.bindVertexArray(vao);
        _ = graphics_mem.sliceToVbo(slice);

        const stride = Color.STRIDE + Vec2.STRIDE;
        Color.setupVaoAttrib(0, stride, 0);
        Vec2.setupVaoAttrib(1, stride, Color.STRIDE);

        return vao;
    }
};
