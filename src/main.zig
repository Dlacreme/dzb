const std = @import("std");
const cmd = @import("./command.zig");
const statement = @import("./statement.zig");

pub fn command_not_implement(c: cmd.Command) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Not implemented: [{s}] =>\n", .{c.raw});
}

pub fn statement_not_implement(c: statement.StatementType) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Not implemented: [{s}] =>\n", .{c});
}

pub fn loop() !bool {
    var buf: [4096]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("dzb $> ", .{});
    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        if (input[0] == '.') {
            // Meta command
            var c = cmd.parseLineIntoCommand(input) catch  {
                try stdout.print("invalid command.\n", .{});
                return true;
            };
            if (c.type == cmd.CommandType.exit) {
                return false;
            }
            try command_not_implement(c);
        } else {
            // Statements
            var stat = statement.parseLineIntoStatement(input) catch {
                try stdout.print("invalid satement.\n", .{});
                return true;
            };
            statement_not_implement(stat);
        }
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
