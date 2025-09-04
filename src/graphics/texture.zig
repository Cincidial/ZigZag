const gl = @import("zopengl").bindings;
const U8RGBA = @import("zam").Png.U8RGBA;

pub const Texture = struct {
    id: gl.Uint,

    /// Deinits png
    pub fn init(png: *U8RGBA) Texture {
        defer png.deinit();

        var id: gl.Uint = 0;
        gl.genTextures(1, &id);

        gl.bindTexture(gl.TEXTURE_2D, id);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);

        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, @intCast(png.width), @intCast(png.height), 0, gl.RGBA, gl.UNSIGNED_BYTE, @ptrCast(png.data));
        gl.generateMipmap(gl.TEXTURE_2D);

        return .{
            .id = id,
        };
    }
};
