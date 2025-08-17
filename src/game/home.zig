const std = @import("std");
const gl = @import("zopengl").bindings;
const app_data = @import("../app_data.zig");
const ColorVertex = @import("../graphics/vertex.zig").ColorVertex;
const Color = @import("../graphics/color.zig").Color;
const Vec2 = @import("../math.zig").Vec2;

pub const Home = struct {
    alloc_once: std.heap.ArenaAllocator,
    alloc_loop: std.heap.ArenaAllocator,
    vao: gl.Uint,

    pub fn init(alloc: std.mem.Allocator) Home {
        const vertices = [_]ColorVertex{
            ColorVertex.init(Color.init(100, 100, 100, 100), .{ .x = -0.5, .y = -0.5 }),
            ColorVertex.init(Color.init(100, 100, 100, 100), .{ .x = 0.5, .y = -0.5 }),
            ColorVertex.init(Color.init(100, 100, 100, 100), .{ .x = 0, .y = 0.5 }),
        };
        const vao = ColorVertex.genVao(&vertices);

        return .{
            .alloc_once = std.heap.ArenaAllocator.init(alloc),
            .alloc_loop = std.heap.ArenaAllocator.init(alloc),
            .vao = vao,
        };
    }

    pub fn deinit(self: Home) void {
        self.alloc_once.deinit();
        self.alloc_loop.deinit();
    }

    pub fn iterate(self: Home) void {
        app_data.simple_shader.use();
        gl.bindVertexArray(self.vao);
        gl.drawArrays(gl.TRIANGLES, 0, 3);
        gl.bindVertexArray(0);
    }
};
