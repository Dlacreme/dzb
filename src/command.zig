
const CommandType = enum {
    exit,
};

pub const Command = struct {
    type: CommandType,
    raw: []u8,
};

pub fn parse_line_into_command(line: []u8) !Command {
    return Command {
        .type = CommandType.exit,
        .raw = line,
    };
}
