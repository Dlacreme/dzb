const std = @import("std");
const cmd = @import("./command.zig");
const exec = @import("./exec.zig");

pub fn loop() !bool {
    var buf: [2048]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("dzb $> ", .{});
    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        var c = cmd.parse_line_into_command(input) catch  {
            try stdout.print("invalid arg\n", .{});
            return true;
        };
        if (c.type == cmd.CommandType.exit) {
            return false;
        }
        try exec.execute(c);
    } else {
        try stdout.print("Failed to read line\n", .{});
    }
    return true;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var keep_alive = true;

    while (keep_alive) {
        keep_alive = try loop();
    }
    try stdout.print("Exit.\n", .{});
}

test "simple test" {}
