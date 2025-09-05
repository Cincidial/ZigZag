const std = @import("std");
const gl = @import("zopengl").bindings;
const zam = @import("zam");
const app_data = @import("../app_data.zig");
const TextureVertex = @import("../graphics/vertex.zig").TextureVertex;
const Color = @import("../graphics/color.zig").Color;
const Vec2 = @import("../math.zig").Vec2;
const Renderer = @import("../graphics/renderer.zig").Renderer;
const Texture = @import("../graphics/texture.zig").Texture;

pub const Home = struct {
    alloc_once: std.heap.ArenaAllocator,
    alloc_loop: std.heap.ArenaAllocator,
    renderer: Renderer,
    texture: Texture,

    pub fn init(alloc: std.mem.Allocator) !Home {
        const vertices = [_]TextureVertex{
            TextureVertex.init(.{ .x = 1.0, .y = 1.0 }, .{ .x = 0.5, .y = 0.5 }),
            TextureVertex.init(.{ .x = 1.0, .y = 0 }, .{ .x = 0.5, .y = -0.5 }),
            TextureVertex.init(.{ .x = 0, .y = 0 }, .{ .x = -0.5, .y = -0.5 }),
            TextureVertex.init(.{ .x = 0, .y = 1.0 }, .{ .x = -0.5, .y = 0.5 }),
        };
        const indices = [_]u16{ 0, 1, 3, 1, 2, 3 };
        const vao = TextureVertex.genVao(&vertices, &indices);

        var png = try zam.Png.asU8RGBA(@embedFile("../raw/textures/test.png"), alloc, true);
        const texture = Texture.init(&png);

        return .{
            .alloc_once = std.heap.ArenaAllocator.init(alloc),
            .alloc_loop = std.heap.ArenaAllocator.init(alloc),
            .renderer = Renderer.init(&app_data.texture_shader, vao, indices.len),
            .texture = texture,
        };
    }

    pub fn deinit(self: Home) void {
        self.alloc_once.deinit();
        self.alloc_loop.deinit();
    }

    pub fn iterate(self: Home) void {
        self.renderer.render(self.texture);
    }
};
