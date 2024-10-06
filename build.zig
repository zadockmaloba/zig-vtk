const std = @import("std");
const vcm = @import("vtk-conf/buildVtkCommon.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const vtk = b.dependency("vtk", .{
        .target = target,
        .optimize = optimize,
    });

    const vtkCommon = vcm.addVtkCommon(b, vtk, target, optimize) catch |err| {
        std.log.err("Error: {} \n", .{err});
        return;
    };

    b.installArtifact(vtkCommon);
}
