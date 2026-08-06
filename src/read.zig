const std = @import("std");

/// Can a symbol (or symbol part) begin with the character 'ch'?
pub fn is_symbol_char_beg(ch: u8) bool {
    return std.ascii.isAlphabetic(ch) or ch == '_' or ch == '+' or ch == '-' or
        ch == '!' or ch == '$' or ch == '*' or ch == '^' or ch == ':' or
        ch == '&' or ch == '?' or ch == '=' or ch == '%';
}

/// Can a symbol (or symbol part) have the character 'ch' as its part (but not begin with)?
pub fn is_symbol_char(ch: u8) bool {
    return is_symbol_char(ch) or std.ascii.isDigit(ch);
}

pub const TokenKind = enum(i32) {
    /// -> '('
    parenOpen,
    /// -> ')'
    parenClose,
    /// -> '['
    parenOpenSquare,
    /// -> ']'
    parenCloseSquare,
    /// -> '{'
    parenOpenCurly,
    /// -> '}'
    parenCloseCurly,
    /// Standalone or multipart
    symbol,
    /// Just a string
    string,
    /// Starts with a '#', e.g. '#true'
    special,
    /// Positive/negative whole number
    integer,
    /// Floating point
    real,
    /// -> '.' (tail specifier)
    dot,
    /// -> ',' (unquote)
    comma,
    /// -> ',*' (unquote-splice)
    commaStar,
    /// -> '@' (mutability specifier)
    at,
    /// -> ';' (semantic delimiter)
    semicolon,
    /// -> \n or \r\n
    /// Newlines are important (semantic delimiter)
    newLine,
};

pub const Token = union(TokenKind) { symbol: []u8, string: []u8, special: []u8, integer: []u8, real: []u8 };

pub const Options = struct {
    /// Instead of allocating memory for symbols, string, specials, etc.
    /// create slices pointing to the source buffer.
    /// Returned tokens will contain these slices.
    return_buffer_slices: bool = false,
};

pub const InitError = error{
    /// Returned when the 'return_buffer_slices' flag isn't set, but
    /// no allocator has been provided
    AllocatorNotProvided,
    /// Returned when the 'return_buffer_slices' flag is set, but
    /// the provided reader isn't fixed (std.Io.Reader.fixed)
    ReaderNotFixed,
};

pub const ReadError = error{
    /// Returned when the allocator provided returned a null
    NotEnoughMemory,
    /// Returned when the current token being parsed isn't finished yet
    /// and the byte_reader has no more bytes left (fixable)
    UnfinishedToken,
    /// Return when a syntax error has been encountered
    InvalidToken,
    /// Returned when the byte_reader has no more bytes left (fixable)
    EndOfStream,
};

/// Lingo basic tokenizer (Reader)
pub fn Reader(comptime opts: Options) type {
    return struct {
        byte_reader: std.Io.Reader,
        allocator: ?std.mem.Allocator,
        cur_kind: ?TokenKind = null,
        cur_line: u32,
        cur_char: u32,

        const Self = @This();

        /// Initialize a new token Reader.
        /// If return_buffer_slices flag is set, byte_reader must be
        /// made with std.Io.Reader.fixed function. If not, an allocator
        /// must be provided.
        pub fn init(byte_reader: std.Io.Reader, allocator: ?std.mem.Allocator) InitError!Self {
            if (opts.return_buffer_slices) {
                // check if byte_reader has fixed buffer
                if (byte_reader.end != byte_reader.buffer.len) {
                    return InitError.ReaderNotFixed;
                }
            } else if (allocator == null) {
                return InitError.AllocatorNotProvided;
            }

            return Self{
                .byte_reader = byte_reader,
                .allocator = allocator,
            };
        }

        pub fn deinit(self: *Self) void {
            _ = self;
        }

        pub fn next(self: *Self) ReadError!Token {
            while (true) {
                const byte = self.byte_reader.takeByte() orelse return ReadError.EndOfStream;
                if (self.cur_kind) |k| {
                    switch (k) {
                        // '\r\n' check
                        .newLine => {
                            self.cur_kind = null;
                            if (byte == '\n') return .newLine;
                            self.byte_reader.seek -= 1;
                        },
                        else => {
                            std.debug.panic("Lingo Reader (tokenizer) got into a faulty state (unexpected self.current_kind\n", .{});
                        },
                    }
                } else {
                    switch (byte) {
                        ' ' => continue,
                        '\t' => continue,
                        // '\r\n' check, otherwise just whitespace
                        '\r' => self.cur_kind = .newLine,
                        '(' => return .parenOpen,
                        ')' => return .parenClose,
                        '[' => return .parenOpenSquare,
                        ']' => return .parenCloseSquare,
                        '{' => return .parenOpenCurly,
                        '}' => return .parenCloseCurly,
                        '.' => return .dot,
                        '@' => return .at,
                        ';' => return .semicolon,
                        '\n' => return .newLine,
                        '"' => self.cur_kind = .string,
                        '#' => self.cur_kind = .special,
                        // comma/commaStar check
                        ',' => self.cur_kind = .comma,
                        else => {
                            // symbol character
                            // digit
                        },
                    }
                }
            }
        }
    };
}

test "providing no allocator must fail" {
    try std.testing.expect(Reader(.{}).init(std.Io.Reader.fixed(""), null) == InitError.AllocatorNotProvided);
}

test "not fixed buffer with RBS flag must fail" {
    var b = [_]u8{1} ** 16;
    const file_reader = std.Io.File.stdin().reader(std.testing.io, &b).interface;
    try std.testing.expect(Reader(.{ .return_buffer_slices = true }).init(file_reader, null) == InitError.ReaderNotFixed);
}
