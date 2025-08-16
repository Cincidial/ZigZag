const std = @import("std");
const gl = @import("zopengl").bindings;

/// Binds the slice provided to a new gl array buffer.
/// The buffer is bound to the currently bound VAO
pub fn sliceToVbo(slice: anytype) gl.Uint {
    const bytes = std.mem.sliceAsBytes(slice);
    var vbo: gl.Uint = 0;

    gl.genBuffers(1, &vbo);
    gl.bindBuffer(gl.ARRAY_BUFFER, vbo);
    gl.bufferData(gl.ARRAY_BUFFER, @intCast(bytes.len), bytes.ptr, gl.STATIC_DRAW);

    return vbo;
}
