const std = @import("std");

const CommandError = error {
    Unknown,
    InvalidArguments,
};

pub const CommandType = enum {
    exit,
};

pub const Arg = struct {
    raw: []const u8,
};

pub const Command = struct {
    raw: []const u8,
    type: CommandType,
    args: std.ArrayList(Arg),
};

pub fn parseLineIntoCommand(line: []u8) !Command {
    var cmd_type: ?CommandType = null;
    var splits = std.mem.split(u8, line, " ");
    var args = std.ArrayList(Arg).init(std.heap.page_allocator);

    while (splits.next()) |chunk| {
        if (cmd_type == null and chunk[0] == '.') {
            cmd_type = parseCommandType(chunk[1..]);
            continue;
        }
        try parseArg(&args, chunk);
    }
    return Command {
        .type = cmd_type orelse return CommandError.Unknown,
        .raw = line,
        .args = args,
    };
}

fn parseCommandType(chunk: []const u8) ?CommandType {
    return std.meta.stringToEnum(CommandType, chunk);
}

fn parseArg(args: *std.ArrayList(Arg), chunk: []const u8) !void {
    try args.append(Arg{
        .raw = chunk,
    });
}
