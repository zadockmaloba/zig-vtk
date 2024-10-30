const std = @import("std");

const TargetOpts = std.Build.ResolvedTarget;
const OptimizeOpts = std.builtin.OptimizeMode;
const Dependency = std.Build.Dependency;
const Builder = std.build.Builder;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const kissFFTPath = "ThirdParty/kissfft/";
pub const exprTKPath = "ThirdParty/exprtk/";
pub const pugiXmlPath = "ThirdParty/pugixml/";

const kissFFTConfigHeaders = &.{"vtk_kissfft.h"};

const kissFFTSources = &.{
    "kiss_fft.c",
    "tools/kiss_fastfir.c",
    "tools/kiss_fftnd.c",
    "tools/kiss_fftndr.c",
    "tools/kiss_fftr.c",
};

const exprTKConfigHeaders = &.{
    "vtk_exprtk.h",
};

const pugiXmlConfigHeaders = &.{
    "vtk_pugixml.h",
    "vtkpugixml/src/pugiconfig.hpp",
};

const pugiXmlSources = &.{
    "src/pugixml.cpp",
};

pub fn addVtkThirdparty(b: *std.Build, dep: *Dependency, target: TargetOpts, optimize: OptimizeOpts) !void {
    var kissFFT = b.addStaticLibrary(.{
        .name = "vtkKissFFT",
        .optimize = optimize,
        .target = target,
    });

    var pugiXml = b.addStaticLibrary(.{
        .name = "vtkPugiXml",
        .optimize = optimize,
        .target = target,
    });

    inline for (kissFFTConfigHeaders) |conf_header| {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(kissFFTPath ++ conf_header ++ ".in") },
                .include_path = conf_header,
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

    inline for (exprTKConfigHeaders) |conf_header| {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(exprTKPath ++ conf_header ++ ".in") },
                .include_path = conf_header,
            },
            .{
                .VTK_MODULE_USE_EXTERNAL_VTK_exprtk = 0,
            },
        );

        kissFFT.addConfigHeader(tmp);
        kissFFT.installConfigHeader(tmp);
    }

    {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(pugiXmlPath ++ "vtk_pugixml.h" ++ ".in") },
                .include_path = "vtk_pugixml.h",
            },
            .{
                .VTK_MODULE_USE_EXTERNAL_vtkpugixml = 0,
                .vtkpugixml_BUILD_SHARED_LIBS = 0,
            },
        );

        pugiXml.addConfigHeader(tmp);
        pugiXml.installConfigHeader(tmp);
    }

    {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(pugiXmlPath ++ "vtkpugixml/src/pugiconfig.hpp" ++ ".in") },
                .include_path = "pugiconfig.hpp",
            },
            .{
                .VTK_MODULE_USE_EXTERNAL_vtkpugixml = 0,
                .vtkpugixml_BUILD_SHARED_LIBS = 0,
            },
        );

        pugiXml.addConfigHeader(tmp);
        pugiXml.installConfigHeader(tmp);
    }

    pugiXml.linkLibCpp();
    pugiXml.addIncludePath(dep.path(pugiXmlPath));
    pugiXml.addIncludePath(dep.path(pugiXmlPath ++ "vtkpugixml"));
    pugiXml.addIncludePath(dep.path(pugiXmlPath ++ "vtkpugixml/src"));
    pugiXml.addCSourceFiles(.{
        .root = dep.path(pugiXmlPath ++ "vtkpugixml"),
        .files = pugiXmlSources,
        .flags = &.{ "-std=c++17", "-Wno-narrowing" },
    });

    b.installArtifact(kissFFT);
    b.installArtifact(pugiXml);
}
