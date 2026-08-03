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

pub fn Reader(comptime opts: Options) type {
    _ = opts;
    return struct {
        const Self = @This();

        fn next(self: Self) ?Token {
            _ = self;
        }
    };
}
