const std = @import("std");
const cmd = @import("./command.zig");

pub fn execute(c: cmd.Command) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("[{s}] =>\n", .{c.raw});
}