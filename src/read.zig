pub const TokenKind = enum(i32) {
    // -> '('
    parenOpen,
    // -> ')'
    parenClose,
    // -> '['
    parenOpenSquare,
    // -> ']'
    parenCloseSquare,
    // -> '{'
    parenOpenCurly,
    // -> '}'
    parenCloseCurly,
    // Standalone or multipart
    symbol,
    // Just a string
    string,
    // Starts with a '#', e.g. '#true'
    special,
    // Positive/negative whole number
    integer,
    // Floating point
    real,
    // -> '.' (tail specifier)
    dot,
    // -> ',' (unquote)
    comma,
    // -> ',*' (unquote-splice)
    commaStar,
    // -> '@' (mutability specifier)
    at,
    // -> ';' (semantic delimiter)
    semicolon,
    // -> \n or \r\n
    // Newlines are important (semantic delimiter)
    newLine,
};

pub const Token = union(TokenKind) {};
