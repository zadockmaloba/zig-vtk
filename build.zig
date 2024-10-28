const std = @import("std");
const vcm = @import("vtk-conf/buildVtkCommon.zig");
const thirdparty = @import("vtk-conf/buildVtkThirdParty.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const vtk = b.dependency("vtk", .{
        .target = target,
        .optimize = optimize,
    });

    thirdparty.addVtkThirdparty(b, vtk, target, optimize) catch |err| {
        std.log.err("Error: {} \n", .{err});
        return;
    };

    vcm.addVtkCommon(b, vtk, target, optimize) catch |err| {
        std.log.err("Error: {} \n", .{err});
        return;
    };
}
