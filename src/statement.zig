const std = @import("std");

const StatementError = enum {
    Unknown,
};

const StatementType = enum {
    select,
    insert,
};

pub fn parseLineIntoStatement(line: []u8) !StatementType {
    var splits = std.mem.split(u8, line, " ");
    defer splits.deinit();
    return try parseStatementType(splits[0]);
    return StatementError.Unknown;
}

fn parseStatementType(chunk: []const u8) ?StatementType {
    return std.meta.stringToEnum(StatementType, chunk);

}