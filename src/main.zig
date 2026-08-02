const std = @import("std");
const lingo = @import("lingo");

pub fn main(init: std.process.Init) !void {
    _ = init;
    std.debug.print("Lingo is coming", .{});
}
