const gl = @import("zopengl").bindings;
const std = @import("std");
const Allocator = @import("std").mem.Allocator;
const Color = @import("color.zig").Color;
const Vec2 = @import("../math.zig").Vec2;
const graphics_mem = @import("memory.zig");

pub const ColorVertex = extern struct {
    color: Color,
    pos: Vec2,

    pub fn init(color: Color, pos: Vec2) ColorVertex {
        return .{
            .color = color,
            .pos = pos,
        };
    }

    pub fn genVao(verticies: []const ColorVertex, indices: []const u16) gl.Uint {
        var vao: gl.Uint = undefined;
        gl.genVertexArrays(1, &vao);

        gl.bindVertexArray(vao);
        _ = graphics_mem.sliceToVbo(verticies);
        _ = graphics_mem.indeciesToEbo(indices);

        const stride = @sizeOf(ColorVertex); // Padding included
        Color.setupVaoAttrib(0, stride, 0);
        Vec2.setupVaoAttrib(1, stride, Color.NO_PADDING_SIZE);

        return vao;
    }
};
