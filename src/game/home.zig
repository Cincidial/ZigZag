const std = @import("std");
const gl = @import("zopengl").bindings;
const app_data = @import("../app_data.zig");
const ColorVertex = @import("../graphics/vertex.zig").ColorVertex;
const Color = @import("../graphics/color.zig").Color;
const Vec2 = @import("../math.zig").Vec2;
const Renderer = @import("../graphics/renderer.zig").Renderer;

pub const Home = struct {
    alloc_once: std.heap.ArenaAllocator,
    alloc_loop: std.heap.ArenaAllocator,
    renderer: Renderer,

    pub fn init(alloc: std.mem.Allocator) Home {
        const tc = Color.init(0.75, 0.1, 0.1, 1);
        const vertices = [_]ColorVertex{
            ColorVertex.init(tc, .{ .x = 0.5, .y = 0.5 }),
            ColorVertex.init(tc, .{ .x = 0.5, .y = -0.5 }),
            ColorVertex.init(tc, .{ .x = -0.5, .y = -0.5 }),
            ColorVertex.init(tc, .{ .x = -0.5, .y = 0.5 }),
        };
        const indices = [_]u16{ 0, 1, 3, 1, 2, 3 };
        const vao = ColorVertex.genVao(&vertices, &indices);

        return .{
            .alloc_once = std.heap.ArenaAllocator.init(alloc),
            .alloc_loop = std.heap.ArenaAllocator.init(alloc),
            .renderer = Renderer.init(&app_data.simple_shader, vao, indices.len),
        };
    }

    pub fn deinit(self: Home) void {
        self.alloc_once.deinit();
        self.alloc_loop.deinit();
    }

    pub fn iterate(self: Home) void {
        self.renderer.render();
    }
};
