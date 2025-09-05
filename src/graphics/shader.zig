const std = @import("std");
const gl = @import("zopengl").bindings;

const Error = error{
    CompileVertexFailed,
    CompileFragmentFailed,
    LinkProgramFailed,
};

fn checkForShaderError(id: gl.Uint, err: Error) Error!void {
    var success: gl.Int = gl.TRUE;
    gl.getShaderiv(id, gl.COMPILE_STATUS, &success);

    if (success == gl.FALSE) {
        var log: [512]u8 = undefined;
        gl.getShaderInfoLog(id, 512, null, &log);

        std.debug.print("{s}\n", .{log});
        return err;
    }
}

pub const Shader = struct {
    id: gl.Uint,

    pub fn init(vs: [*:0]const u8, fs: [*:0]const u8) Error!Shader {
        const vs_id = gl.createShader(gl.VERTEX_SHADER);
        gl.shaderSource(vs_id, 1, &vs, null);
        gl.compileShader(vs_id);
        try checkForShaderError(vs_id, Error.CompileVertexFailed);

        const fs_id = gl.createShader(gl.FRAGMENT_SHADER);
        gl.shaderSource(fs_id, 1, &fs, null);
        gl.compileShader(fs_id);
        try checkForShaderError(fs_id, Error.CompileFragmentFailed);

        const shader_id = gl.createProgram();
        gl.attachShader(shader_id, vs_id);
        gl.attachShader(shader_id, fs_id);
        gl.linkProgram(shader_id);
        try checkForShaderError(shader_id, Error.LinkProgramFailed);

        gl.deleteShader(vs_id);
        gl.deleteShader(fs_id);

        return .{
            .id = shader_id,
        };
    }

    pub fn deinit(self: Shader) void {
        gl.deleteProgram(self.id);
    }

    pub fn use(self: Shader) void {
        gl.useProgram(self.id);
    }

    pub fn setInt(self: Shader, name: [*c]const gl.Char, value: i32) void {
        self.use();
        gl.uniform1i(gl.getUniformLocation(self.id, name), value);
    }
};
