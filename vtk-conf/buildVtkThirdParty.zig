const std = @import("std");

const TargetOpts = std.Build.ResolvedTarget;
const OptimizeOpts = std.builtin.OptimizeMode;
const Dependency = std.Build.Dependency;
const Builder = std.build.Builder;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const kissFFTPath = "ThirdParty/kissfft/";

pub const kissFFTConfigHeaders = &.{"vtk_kissfft.h"};

const kissFFTSources = &.{
    "kiss_fft.c",
    "tools/kiss_fastfir.c",
    "tools/kiss_fftnd.c",
    "tools/kiss_fftndr.c",
    "tools/kiss_fftr.c",
};

pub fn addVtkThirdparty(b: *std.Build, dep: *Dependency, target: TargetOpts, optimize: OptimizeOpts) !void {
    var kissFFT = b.addStaticLibrary(.{
        .name = "vtkKissFFT",
        .optimize = optimize,
        .target = target,
    });

    inline for (kissFFTConfigHeaders) |conf_header| {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(kissFFTPath ++ conf_header ++ ".in") },
                .include_path = "vtkkissfft/" ++ conf_header,
            },
            .{
                .VTK_MODULE_USE_EXTERNAL_vtkkissfft = 0,
            },
        );

        kissFFT.addConfigHeader(tmp);
        kissFFT.installConfigHeader(tmp);
    }

    kissFFT.linkLibC();
    kissFFT.addIncludePath(dep.path(kissFFTPath));
    kissFFT.addIncludePath(dep.path(kissFFTPath ++ "vtkkissfft"));
    kissFFT.addIncludePath(dep.path(kissFFTPath ++ "vtkkissfft/tools"));

    kissFFT.addCSourceFiles(.{
        .root = dep.path(kissFFTPath ++ "vtkkissfft"),
        .files = kissFFTSources,
        .flags = &.{ "-std=c17", "-Wno-narrowing" },
    });

    b.installArtifact(kissFFT);
}
