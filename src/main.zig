const std = @import("std");
const cmd = @import("./command.zig");
const exec = @import("./exec.zig");

pub fn loop() !void {
    var buf: [2048]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("udb $>", .{});
    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        var c = cmd.parse_line_into_command(input) catch {
            try stdout.print("Failed to parse line:\n{s}\n\n", .{input});
        };
        try exec.execute(c);
    } else {
        try stdout.print("Failed to read line\n", .{});
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    while (true) {
        loop() catch {
            try stdout.print("unexpecetedet error. Please try never again.\n", .{});
        };
    }
}

test "simple test" {}
