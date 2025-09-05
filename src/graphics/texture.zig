const gl = @import("zopengl").bindings;
const U8RGBA = @import("zam").Png.U8RGBA;
const std = @import("std");

pub const Texture = struct {
    id: gl.Uint,

    /// Deinits the png
    pub fn init(png: *U8RGBA) Texture {
        defer png.deinit();

        var id: gl.Uint = 0;
        gl.genTextures(1, &id);

        gl.bindTexture(gl.TEXTURE_2D, id);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);

        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, @intCast(png.width), @intCast(png.height), 0, gl.RGBA, gl.UNSIGNED_BYTE, @ptrCast(png.data));
        gl.generateMipmap(gl.TEXTURE_2D);

        return .{
            .id = id,
        };
    }

    pub fn use(self: Texture, pos: comptime_int) void {
        gl.activeTexture(pos);
        gl.bindTexture(gl.TEXTURE_2D, self.id);
    }
};
