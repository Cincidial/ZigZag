const std = @import("std");

pub const Home = struct {
    alloc_once: std.heap.ArenaAllocator,
    alloc_loop: std.heap.ArenaAllocator,

    pub fn deinit(self: Home) void {
        self.alloc_once.deinit();
        self.alloc_loop.deinit();
    }

    pub fn iterate(_: Home) void {}
};

pub fn init(alloc: std.mem.Allocator) Home {
    return .{
        .alloc_once = std.heap.ArenaAllocator.init(alloc),
        .alloc_loop = std.heap.ArenaAllocator.init(alloc),
    };
}
