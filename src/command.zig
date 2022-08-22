const std = @import("std");

const CommandError = error {
    Unknown,
    InvalidArguments,
};

pub const CommandType = enum {
    exit,
};

pub const Command = struct {
    type: CommandType,
    raw: []u8,
};

pub fn parse_line_into_command(line: []u8) !Command {
    var cmd_type: ?CommandType = null;
    var splits = std.mem.split(u8, line, " ");

    while (splits.next()) |chunk| {
        if (cmd_type == null) {
            cmd_type = parse_command_type(chunk);
            continue;
        }
        std.debug.print("type set so now deal with > {s}\n", .{chunk});
    }
    return Command {
        .type = cmd_type orelse return CommandError.Unknown,
        .raw = line,
    };
}

fn parse_command_type(chunk: []const u8) ?CommandType {
    return std.meta.stringToEnum(CommandType, chunk);
}
