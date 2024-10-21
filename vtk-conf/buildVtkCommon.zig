const std = @import("std");

const TargetOpts = std.Build.ResolvedTarget;
const OptimizeOpts = std.builtin.OptimizeMode;
const Dependency = std.Build.Dependency;

const commonCorePath = "Common/Core/";
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
    "vtkTypedArray.h",
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
        .flags = &.{"-std=c++14"},
    });

    vtkSys.linkLibCpp();

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
            },
        );

        commonCore.addConfigHeader(tmp);
    }

    commonCore.defineCMacro("VTK_SMP_IMPLEMENTATION_TYPE", "Sequential");
    //commonCore.defineCMacro("VTK_MAX_THREADS", "64");

    commonCore.linkLibCpp();
    commonCore.linkLibrary(vtkSys);
    commonCore.addIncludePath(dep.path("Common/Core"));
    commonCore.addIncludePath(dep.path("Utilities/KWIML"));
    commonCore.addIncludePath(dep.path("Utilities/KWSys"));
    commonCore.addIncludePath(b.path("include"));
    commonCore.addCSourceFiles(.{
        .root = dep.path(commonCorePath),
        .files = &commonCoreSources,
        .flags = &.{"-std=c++14"},
    });
    return commonCore;
}
