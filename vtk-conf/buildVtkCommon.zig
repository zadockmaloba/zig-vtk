const std = @import("std");

const TargetOpts = std.Build.ResolvedTarget;
const OptimizeOpts = std.builtin.OptimizeMode;
const Dependency = std.Build.Dependency;
const Builder = std.build.Builder;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const commonCorePath = "Common/Core/";
const commonDataModelPath = "Common/DataModel/";
const vtkSysPath = "Utilities/KWSys/vtksys/";

const commonCoreConfigHeaders = .{
    "vtkABINamespace.h",
    "vtkArrayDispatchArrayList.h",
    "vtkBuild.h",
    "vtkDebug.h",
    "vtkDebugRangeIterators.h",
    "vtkEndian.h",
    "vtkFeatures.h",
    "vtkFloatingPointExceptionsConfigure.h",
    "vtkLegacy.h",
    "vtkMathConfigure.h",
    "vtkOptions.h",
    "vtkPlatform.h",
    "vtkSMP.h",
    "vtkThreads.h",
    //"vtkTypedArray.h",
    "vtkTypeListMacros.h",
    "vtkVersionMacros.h",
    "vtkVersionFull.h",
    "vtkVTK_USE_SCALED_SOA_ARRAYS.h",
    "vtkVTK_DISPATCH_IMPLICIT_ARRAYS.h",
};

const commonCoreSources = .{
    "vtkAbstractArray.cxx",
    "vtkAnimationCue.cxx",
    "vtkArchiver.cxx",
    "vtkArray.cxx",
    "vtkArrayCoordinates.cxx",
    "vtkArrayExtents.cxx",
    "vtkArrayExtentsList.cxx",
    "vtkArrayIterator.cxx",
    "vtkArrayRange.cxx",
    "vtkArraySort.cxx",
    "vtkArrayWeights.cxx",
    "vtkAtomicMutex.cxx",
    "vtkBitArray.cxx",
    "vtkBitArrayIterator.cxx",
    "vtkBoxMuellerRandomSequence.cxx",
    "vtkBreakPoint.cxx",
    "vtkByteSwap.cxx",
    "vtkCallbackCommand.cxx",
    "vtkCharArray.cxx",
    "vtkCollection.cxx",
    "vtkCollectionIterator.cxx",
    "vtkCommand.cxx",
    "vtkCommonInformationKeyManager.cxx",
    "vtkDataArray.cxx",
    "vtkDataArrayCollection.cxx",
    "vtkDataArrayCollectionIterator.cxx",
    "vtkDataArraySelection.cxx",
    "vtkDebugLeaks.cxx",
    "vtkDebugLeaksManager.cxx",
    "vtkDoubleArray.cxx",
    "vtkDynamicLoader.cxx",
    "vtkEventForwarderCommand.cxx",
    "vtkFileOutputWindow.cxx",
    "vtkFloatArray.cxx",
    "vtkFloatingPointExceptions.cxx",
    "vtkGarbageCollector.cxx",
    "vtkGarbageCollectorManager.cxx",
    "vtkGaussianRandomSequence.cxx",
    "vtkIdList.cxx",
    "vtkIdListCollection.cxx",
    "vtkIdTypeArray.cxx",
    "vtkIndent.cxx",
    "vtkInformation.cxx",
    "vtkInformationDataObjectKey.cxx",
    "vtkInformationDoubleKey.cxx",
    "vtkInformationDoubleVectorKey.cxx",
    "vtkInformationIdTypeKey.cxx",
    "vtkInformationInformationKey.cxx",
    "vtkInformationInformationVectorKey.cxx",
    "vtkInformationIntegerKey.cxx",
    "vtkInformationIntegerPointerKey.cxx",
    "vtkInformationIntegerVectorKey.cxx",
    "vtkInformationIterator.cxx",
    "vtkInformationKey.cxx",
    "vtkInformationKeyLookup.cxx",
    "vtkInformationKeyVectorKey.cxx",
    "vtkInformationObjectBaseKey.cxx",
    "vtkInformationObjectBaseVectorKey.cxx",
    "vtkInformationRequestKey.cxx",
    "vtkInformationStringKey.cxx",
    "vtkInformationStringVectorKey.cxx",
    "vtkInformationUnsignedLongKey.cxx",
    "vtkInformationVariantKey.cxx",
    "vtkInformationVariantVectorKey.cxx",
    "vtkInformationVector.cxx",
    "vtkIntArray.cxx",
    "vtkLargeInteger.cxx",
    "vtkLogger.cxx",
    "vtkLongArray.cxx",
    "vtkLongLongArray.cxx",
    "vtkLookupTable.cxx",
    "vtkMath.cxx",
    "vtkMersenneTwister.cxx",
    "vtkMinimalStandardRandomSequence.cxx",
    "vtkMultiThreader.cxx",
    "vtkOStrStreamWrapper.cxx",
    "vtkOStreamWrapper.cxx",
    "vtkObject.cxx",
    "vtkObjectBase.cxx",
    "vtkObjectFactory.cxx",
    "vtkObjectFactoryCollection.cxx",
    "vtkOldStyleCallbackCommand.cxx",
    "vtkOutputWindow.cxx",
    "vtkOverrideInformation.cxx",
    "vtkOverrideInformationCollection.cxx",
    "vtkPoints.cxx",
    "vtkPoints2D.cxx",
    "vtkPriorityQueue.cxx",
    "vtkRandomPool.cxx",
    "vtkRandomSequence.cxx",
    "vtkReferenceCount.cxx",
    "vtkScalarsToColors.cxx",
    "vtkShortArray.cxx",
    "vtkSignedCharArray.cxx",
    "vtkSmartPointerBase.cxx",
    "vtkSortDataArray.cxx",
    "vtkStdString.cxx",
    "vtkStringArray.cxx",
    "vtkStringOutputWindow.cxx",
    "vtkStringToken.cxx",
    "vtkTimePointUtility.cxx",
    "vtkTimeStamp.cxx",
    "vtkUnsignedCharArray.cxx",
    "vtkUnsignedIntArray.cxx",
    "vtkUnsignedLongArray.cxx",
    "vtkUnsignedLongLongArray.cxx",
    "vtkUnsignedShortArray.cxx",
    "vtkVariant.cxx",
    "vtkVariantArray.cxx",
    "vtkVersion.cxx",
    "vtkVoidArray.cxx",
    "vtkWeakPointerBase.cxx",
    "vtkWeakReference.cxx",
    "vtkWindow.cxx",
    "vtkXMLFileOutputWindow.cxx",
};

const vtkSysConfigHeaders = &.{
    "Base64.h",
    "CommandLineArguments.hxx",
    "Configure.h",
    "Configure.hxx",
    "ConsoleBuf.hxx",
    "Directory.hxx",
    "DynamicLoader.hxx",
    "Encoding.h",
    "Encoding.hxx",
    "FStream.hxx",
    "Glob.hxx",
    "MD5.h",
    "Process.h",
    "RegularExpression.hxx",
    "SharedForward.h",
    "Status.hxx",
    "String.h",
    "String.hxx",
    "System.h",
    "SystemInformation.hxx",
    "SystemTools.hxx",
    "Terminal.h",
};

const vtkSysSources = .{
    "CommandLineArguments.cxx",
    "Directory.cxx",
    "DynamicLoader.cxx",
    "EncodingCXX.cxx",
    "FStream.cxx",
};

const VtkConfErrors = error{
    ConfFileNotFound,
};

pub fn addVtkCommon(b: *std.Build, dep: *Dependency, target: TargetOpts, optimize: OptimizeOpts) !*std.Build.Step.Compile {
    var commonCore = b.addStaticLibrary(.{
        .name = "vtkCommonCore",
        .target = target,
        .optimize = optimize,
    });

    //var commonDataModel = b.addStaticLibrary(.{
    //    .name = "vtkCommonDataModel",
    //    .target = target,
    //    .optimize = optimize,
    //});

    var vtkSys = b.addStaticLibrary(.{
        .name = "vtkSys",
        .target = target,
        .optimize = optimize,
    });

    // Step to install configuration headers before building vtkSys
    //const install_headers = b.step("install-vtksys-headers", "Install vtksys configuration headers");

    inline for (vtkSysConfigHeaders) |conf_header| {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(vtkSysPath ++ conf_header ++ ".in") },
                .include_path = "vtksys/" ++ conf_header,
            },
            .{
                .KWSYS_NAMESPACE = .vtksys,
                .KWSYS_BUILD_SHARED = 0,
                .KWSYS_NAME_IS_KWSYS = 0,
                .KWSYS_STL_HAS_WSTRING = 1,
                .KWSYS_CXX_HAS_EXT_STDIO_FILEBUF_H = 0,
                .KWSYS_SYSTEMTOOLS_USE_TRANSLATION_MAP = 1,
            },
        );

        vtkSys.addConfigHeader(tmp);
        commonCore.addConfigHeader(tmp);
    }

    vtkSys.defineCMacro("KWSYS_NAMESPACE", "vtksys");

    vtkSys.addCSourceFiles(.{
        .root = dep.path(vtkSysPath),
        .files = &vtkSysSources,
        .flags = &.{"-std=c++17"},
    });

    vtkSys.linkLibCpp();

    var arrDispatch = try Dispatch.init(b.allocator);
    defer arrDispatch.deinit();

    try arrDispatch.createArrayDispatch("vtkAffineArray", default_array_types);
    try arrDispatch.createArrayDispatch("vtkConstantArray", default_array_types);
    try arrDispatch.createArrayDispatch("vtkStdFunctionArray", default_array_types);
    try arrDispatch.generateArrayDispatchHeader();

    inline for (commonCoreConfigHeaders) |conf_header| {
        const tmp = b.addConfigHeader(
            .{
                .style = .{ .cmake = dep.path(commonCorePath ++ conf_header ++ ".in") },
                .include_path = conf_header,
            },
            .{
                .VTK_MAJOR_VERSION = 9,
                .VTK_MINOR_VERSION = 3,
                .VTK_BUILD_VERSION = 1,
                .VTK_VERSION_FULL = .@"9.3.1",
                .VTK_DEBUG_LEAKS = 1,
                .VTK_SMP_ENABLE_SEQUENTIAL = 1,
                .VTK_SMP_DEFAULT_IMPLEMENTATION_SEQUENTIAL = 1,
                .VTK_MAX_THREADS = 64,
                .VTK_USE_SCALED_SOA_ARRAYS = 0,
                .VTK_DISPATCH_AFFINE_ARRAYS = 1,
                .VTK_DISPATCH_CONSTANT_ARRAYS = 1,
                .VTK_DISPATCH_STD_FUNCTION_ARRAYS = 1,
                .VTK_ARRAYDISPATCH_ARRAY_LIST = arrDispatch.result.items,
            },
        );

        commonCore.addConfigHeader(tmp);
    }

    commonCore.defineCMacro("VTK_SMP_IMPLEMENTATION_TYPE", "Sequential");
    commonCore.defineCMacro("VTKCOMMONCORE_STATIC_DEFINE", "1");
    //commonCore.defineCMacro("VTK_MAX_THREADS", "64");

    commonCore.linkLibCpp();
    commonCore.linkLibrary(vtkSys);
    commonCore.addIncludePath(dep.path(commonCorePath));
    commonCore.addIncludePath(dep.path(commonDataModelPath));
    commonCore.addIncludePath(dep.path("Utilities/KWIML"));
    commonCore.addIncludePath(dep.path("Utilities/KWSys"));
    commonCore.addIncludePath(b.path("include"));
    commonCore.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonCore.addCSourceFiles(.{
        .root = dep.path(commonCorePath),
        .files = &commonCoreSources,
        .flags = &.{"-std=c++17"},
    });
    return commonCore;
}

const vtk_types = &.{
    "Int8",
    "Int16",
    "Int32",
    "Int64",
    "UInt8",
    "UInt16",
    "UInt32",
    "UInt64",
    "Float32",
    "Float64",
};

// Define the default set of scalar types
const default_array_types = &.{
    "char",
    "double",
    "float",
    "int",
    "long",
    "long long",
    "short",
    "signed char",
    "unsigned char",
    "unsigned int",
    "unsigned long",
    "unsigned long long",
    "unsigned short",
    "vtkIdType",
};

// Create a structure to store dispatch information
pub const Dispatch = struct {
    containers: ArrayList([]const u8),
    headers: ArrayList([]const u8),
    arrays: ArrayList([]const u8),
    readonly_arrays: ArrayList([]const u8),
    result: ArrayList(u8),
    allocator: Allocator,

    pub fn init(allocator: Allocator) !Dispatch {
        return Dispatch{
            .containers = ArrayList([]const u8).init(allocator),
            .headers = ArrayList([]const u8).init(allocator),
            .arrays = ArrayList([]const u8).init(allocator),
            .readonly_arrays = ArrayList([]const u8).init(allocator),
            .result = ArrayList(u8).init(allocator),
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Dispatch) void {
        self.containers.deinit();
        self.headers.deinit();
        self.arrays.deinit();
        self.readonly_arrays.deinit();
    }

    // Helper function to create an array dispatch
    pub fn createArrayDispatch(dispatch: *Dispatch, class: []const u8, types: []const []const u8) !void {
        try dispatch.containers.append(class);
        try dispatch.headers.append(try std.fmt.allocPrint(dispatch.allocator, "{s}.h", .{class}));
        for (types) |value_type| {
            try dispatch.arrays.append(try std.fmt.allocPrint(dispatch.allocator, "{s}<{s}>", .{ class, value_type }));
        }
    }

    pub fn createArrayDispatchImplicit(dispatch: *Dispatch, class: []const u8, types: []const []const u8) !void {
        try dispatch.containers.append(class);
        try dispatch.headers.append(try std.fmt.allocPrint(dispatch.allocator, "{s}.h", .{class}));
        for (types) |value_type| {
            try dispatch.arrays.append(try std.fmt.allocPrint(dispatch.allocator, "{s}<{s}>", .{ class, value_type }));
        }
    }

    // Function to generate array dispatch header
    pub fn generateArrayDispatchHeader(dispatch: *Dispatch) !void {
        try dispatch.result.appendSlice("// SPDX-License-Identifier: BSD-3-Clause\n");
        try dispatch.result.appendSlice("// This file is autogenerated. Do not edit.\n\n");
        try dispatch.result.appendSlice("#ifndef vtkArrayDispatchArrayList_h\n");
        try dispatch.result.appendSlice("#define vtkArrayDispatchArrayList_h\n\n");
        try dispatch.result.appendSlice("#include <vtkTypeList.h>\n");

        for (dispatch.headers.items) |header| {
            try dispatch.result.appendSlice(try std.fmt.allocPrint(dispatch.allocator, "#include \"{s}\"\n", .{header}));
        }

        try dispatch.result.appendSlice("\nnamespace vtkArrayDispatch {\n");
        try dispatch.result.appendSlice("VTK_ABI_NAMESPACE_BEGIN\n\n");

        try dispatch.result.appendSlice("typedef vtkTypeList::Unique<\n");
        try dispatch.result.appendSlice("  vtkTypeList::Create<");

        var separator: []const u8 = "";
        for (dispatch.arrays.items) |array| {
            try dispatch.result.appendSlice(try std.fmt.allocPrint(dispatch.allocator, "{s}\n    {s}", .{ separator, array }));
            separator = ",";
        }

        try dispatch.result.appendSlice("\n  >\n>::Result Arrays;\n\n");

        try dispatch.result.appendSlice("typedef vtkTypeList::Unique<\n");
        try dispatch.result.appendSlice("  vtkTypeList::Create<\n");

        separator = "";
        for (dispatch.readonly_arrays.items) |array| {
            try dispatch.result.appendSlice(try std.fmt.allocPrint(dispatch.allocator, "{s}\n    {s}", .{ separator, array }));
            separator = ",";
        }

        try dispatch.result.appendSlice("\n  >\n>::Result ReadOnlyArrays;\n\n");

        try dispatch.result.appendSlice("typedef vtkTypeList::Unique<\n");
        try dispatch.result.appendSlice("vtkTypeList::Append<Arrays,\nReadOnlyArrays>::Result\n>::Result AllArrays;\n\n");

        try dispatch.result.appendSlice("VTK_ABI_NAMESPACE_END\n\n");
        try dispatch.result.appendSlice("} // end namespace vtkArrayDispatch\n");
        try dispatch.result.appendSlice("#endif // vtkArrayDispatchArrayList_h\n");
    }
};
