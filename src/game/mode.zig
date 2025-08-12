const std = @import("std");
const Home = @import("home.zig").Home;

pub const Mode = union(enum) {
    home: Home,

    pub fn deinit(self: Mode) void {
        switch (self) {
            .home => |*v| v.*.deinit(),
        }
    }

    pub fn iterate(self: Mode) void {
        switch (self) {
            .home => |*v| v.*.iterate(),
        }
    }
};
