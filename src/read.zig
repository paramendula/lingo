const std = @import("std");

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

pub fn Reader(comptime opts: Options) type {
    return struct {
        byte_reader: std.Io.Reader,
        allocator: ?std.mem.Allocator,
        current_kind: ?TokenKind,

        const Self = @This();

        pub fn init(byte_reader: std.Io.Reader, allocator: ?std.mem.Allocator) InitError!Reader {
            if (opts.return_buffer_slices) {
                // TODO: check if fixed
            } else if (!allocator) {
                return .AllocatorNotProvided;
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
            const byte = self.byte_reader.takeByte() orelse return .EndOfStream;
            if (self.current_kind) |k| {
                _ = k;
            } else {
                switch (byte) {
                    '(' => return .parenOpen,
                    ')' => return .parenClose,
                    '[' => return .parenOpenSquare,
                    ']' => return .parenCloseSquare,
                    '{' => return .parenOpenCurly,
                    '}' => return .parenCloseCurly,
                    '.' => return .dot,
                    '@' => return .at,
                    ';' => return .semicolon,
                }
            }
        }
    };
}
