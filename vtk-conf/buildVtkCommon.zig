const std = @import("std");

const thirdparty = @import("buildVtkThirdParty.zig");

const TargetOpts = std.Build.ResolvedTarget;
const OptimizeOpts = std.builtin.OptimizeMode;
const Dependency = std.Build.Dependency;
const Builder = std.build.Builder;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const commonCorePath = "Common/Core/";
const commonDataModelPath = "Common/DataModel/";
const commonMathPath = "Common/Math/";
const commonTransformsPath = "Common/Transforms/";
const commonMiscPath = "Common/Misc/";
const commonSystemPath = "Common/System/";
const vtkSysPath = "Utilities/KWSys/vtksys/";

const commonCoreConfigHeaders = .{
    "vtkABINamespace.h",
    "vtkArrayDispatchArrayList.h",
    "vtkBuild.h",
    "vtkCxxABIConfigure.h",
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

const commonDataModelConfigHeaders = &.{};

const commonDataModelSources = &.{
    "vtkAMRBox.cxx",
    "vtkAMRUtilities.cxx",
    "vtkAbstractCellLinks.cxx",
    "vtkAbstractCellLocator.cxx",
    "vtkAbstractElectronicData.cxx",
    "vtkAbstractPointLocator.cxx",
    "vtkAdjacentVertexIterator.cxx",
    "vtkAnimationScene.cxx",
    "vtkAnnotation.cxx",
    "vtkAnnotationLayers.cxx",
    "vtkArrayData.cxx",
    "vtkAtom.cxx",
    "vtkAttributesErrorMetric.cxx",
    "vtkBSPCuts.cxx",
    "vtkBSPIntersections.cxx",
    "vtkBezierCurve.cxx",
    "vtkBezierHexahedron.cxx",
    "vtkBezierInterpolation.cxx",
    "vtkBezierQuadrilateral.cxx",
    "vtkBezierTetra.cxx",
    "vtkBezierTriangle.cxx",
    "vtkBezierWedge.cxx",
    "vtkBiQuadraticQuad.cxx",
    "vtkBiQuadraticQuadraticHexahedron.cxx",
    "vtkBiQuadraticQuadraticWedge.cxx",
    "vtkBiQuadraticTriangle.cxx",
    "vtkBond.cxx",
    "vtkBoundingBox.cxx",
    "vtkBox.cxx",
    "vtkCell.cxx",
    "vtkCell3D.cxx",
    "vtkCellArray.cxx",
    "vtkCellArrayIterator.cxx",
    "vtkCellAttribute.cxx",
    "vtkCellData.cxx",
    "vtkCellGrid.cxx",
    "vtkCellGridBoundsQuery.cxx",
    "vtkCellGridResponders.cxx",
    "vtkCellGridSidesQuery.cxx",
    "vtkCellIterator.cxx",
    "vtkCellLinks.cxx",
    "vtkCellLocator.cxx",
    "vtkCellLocatorStrategy.cxx",
    "vtkCellMetadata.cxx",
    "vtkCellTreeLocator.cxx",
    "vtkCellTypes.cxx",
    "vtkClosestNPointsStrategy.cxx",
    "vtkClosestPointStrategy.cxx",
    "vtkCompositeDataIterator.cxx",
    "vtkCompositeDataSet.cxx",
    "vtkCone.cxx",
    "vtkConvexPointSet.cxx",
    "vtkCoordinateFrame.cxx",
    "vtkCubicLine.cxx",
    "vtkCylinder.cxx",
    "vtkDataAssembly.cxx",
    "vtkDataAssemblyUtilities.cxx",
    "vtkDataObject.cxx",
    "vtkDataObjectCollection.cxx",
    "vtkDataObjectTree.cxx",
    "vtkDataObjectTreeIterator.cxx",
    "vtkDataObjectTypes.cxx",
    "vtkDataSet.cxx",
    "vtkDataSetAttributes.cxx",
    "vtkDataSetAttributesFieldList.cxx",
    "vtkDataSetCellIterator.cxx",
    "vtkDataSetCollection.cxx",
    "vtkDirectedAcyclicGraph.cxx",
    "vtkDirectedGraph.cxx",
    "vtkDistributedGraphHelper.cxx",
    "vtkEdgeListIterator.cxx",
    "vtkEdgeTable.cxx",
    "vtkEmptyCell.cxx",
    "vtkExplicitStructuredGrid.cxx",
    "vtkExtractStructuredGridHelper.cxx",
    "vtkFieldData.cxx",
    "vtkFindCellStrategy.cxx",
    "vtkGenericAdaptorCell.cxx",
    "vtkGenericAttribute.cxx",
    "vtkGenericAttributeCollection.cxx",
    "vtkGenericCell.cxx",
    "vtkGenericCellIterator.cxx",
    "vtkGenericCellTessellator.cxx",
    "vtkGenericDataSet.cxx",
    "vtkGenericEdgeTable.cxx",
    "vtkGenericInterpolatedVelocityField.cxx",
    "vtkGenericPointIterator.cxx",
    "vtkGenericSubdivisionErrorMetric.cxx",
    "vtkGeometricErrorMetric.cxx",
    "vtkGraph.cxx",
    "vtkGraphEdge.cxx",
    "vtkGraphInternals.cxx",
    "vtkHexagonalPrism.cxx",
    "vtkHexahedron.cxx",
    "vtkHierarchicalBoxDataIterator.cxx",
    "vtkHierarchicalBoxDataSet.cxx",
    "vtkHigherOrderCurve.cxx",
    "vtkHigherOrderHexahedron.cxx",
    "vtkHigherOrderInterpolation.cxx",
    "vtkHigherOrderQuadrilateral.cxx",
    "vtkHigherOrderTetra.cxx",
    "vtkHigherOrderTriangle.cxx",
    "vtkHigherOrderWedge.cxx",
    "vtkHyperTree.cxx",
    "vtkHyperTreeCursor.cxx",
    "vtkHyperTreeGrid.cxx",
    "vtkHyperTreeGridLocator.cxx",
    "vtkHyperTreeGridGeometricLocator.cxx",
    "vtkHyperTreeGridNonOrientedCursor.cxx",
    "vtkHyperTreeGridNonOrientedGeometryCursor.cxx",
    "vtkHyperTreeGridNonOrientedUnlimitedGeometryCursor.cxx",
    "vtkHyperTreeGridNonOrientedMooreSuperCursor.cxx",
    "vtkHyperTreeGridNonOrientedMooreSuperCursorLight.cxx",
    "vtkHyperTreeGridNonOrientedUnlimitedMooreSuperCursor.cxx",
    "vtkHyperTreeGridNonOrientedSuperCursor.cxx",
    "vtkHyperTreeGridNonOrientedSuperCursorLight.cxx",
    "vtkHyperTreeGridNonOrientedUnlimitedSuperCursor.cxx",
    "vtkHyperTreeGridNonOrientedVonNeumannSuperCursor.cxx",
    "vtkHyperTreeGridNonOrientedVonNeumannSuperCursorLight.cxx",
    "vtkHyperTreeGridOrientedCursor.cxx",
    "vtkHyperTreeGridOrientedGeometryCursor.cxx",
    "vtkImageData.cxx",
    "vtkImageIterator.cxx",
    "vtkImageTransform.cxx",
    "vtkImplicitBoolean.cxx",
    "vtkImplicitDataSet.cxx",
    "vtkImplicitFunction.cxx",
    "vtkImplicitFunctionCollection.cxx",
    "vtkImplicitHalo.cxx",
    "vtkImplicitSelectionLoop.cxx",
    "vtkImplicitSum.cxx",
    "vtkImplicitVolume.cxx",
    "vtkImplicitWindowFunction.cxx",
    "vtkInEdgeIterator.cxx",
    "vtkIncrementalOctreeNode.cxx",
    "vtkIncrementalOctreePointLocator.cxx",
    "vtkIncrementalPointLocator.cxx",
    "vtkInformationQuadratureSchemeDefinitionVectorKey.cxx",
    "vtkIterativeClosestPointTransform.cxx",
    "vtkKdNode.cxx",
    "vtkKdTree.cxx",
    "vtkKdTreePointLocator.cxx",
    "vtkLagrangeCurve.cxx",
    "vtkLagrangeHexahedron.cxx",
    "vtkLagrangeInterpolation.cxx",
    "vtkLagrangeQuadrilateral.cxx",
    "vtkLagrangeTetra.cxx",
    "vtkLagrangeTriangle.cxx",
    "vtkLagrangeWedge.cxx",
    "vtkLine.cxx",
    "vtkLocator.cxx",
    "vtkMarchingCubesTriangleCases.cxx",
    "vtkMarchingCubesPolygonCases.cxx",
    "vtkMarchingSquaresLineCases.cxx",
    "vtkMeanValueCoordinatesInterpolator.cxx",
    "vtkMergePoints.cxx",
    "vtkMolecule.cxx",
    "vtkMultiBlockDataSet.cxx",
    "vtkMultiPieceDataSet.cxx",
    "vtkMutableDirectedGraph.cxx",
    "vtkMutableUndirectedGraph.cxx",
    "vtkNonLinearCell.cxx",
    "vtkNonMergingPointLocator.cxx",
    "vtkOctreePointLocator.cxx",
    "vtkOctreePointLocatorNode.cxx",
    "vtkOrderedTriangulator.cxx",
    "vtkOutEdgeIterator.cxx",
    "vtkPartitionedDataSet.cxx",
    "vtkPartitionedDataSetCollection.cxx",
    "vtkPath.cxx",
    "vtkPentagonalPrism.cxx",
    "vtkPerlinNoise.cxx",
    "vtkPiecewiseFunction.cxx",
    "vtkPixel.cxx",
    "vtkPixelExtent.cxx",
    "vtkPixelTransfer.cxx",
    "vtkPlane.cxx",
    "vtkPlaneCollection.cxx",
    "vtkPlanes.cxx",
    "vtkPlanesIntersection.cxx",
    "vtkPointData.cxx",
    "vtkPointLocator.cxx",
    "vtkPointSet.cxx",
    "vtkPointSetCellIterator.cxx",
    "vtkPointsProjectedHull.cxx",
    "vtkPolyData.cxx",
    "vtkPolyDataCollection.cxx",
    "vtkPolyLine.cxx",
    "vtkPolyPlane.cxx",
    "vtkPolyVertex.cxx",
    "vtkPolygon.cxx",
    "vtkPolyhedron.cxx",
    "vtkPolyhedronUtilities.cxx",
    "vtkPyramid.cxx",
    "vtkQuad.cxx",
    "vtkQuadraticEdge.cxx",
    "vtkQuadraticHexahedron.cxx",
    "vtkQuadraticLinearQuad.cxx",
    "vtkQuadraticLinearWedge.cxx",
    "vtkQuadraticPolygon.cxx",
    "vtkQuadraticPyramid.cxx",
    "vtkQuadraticQuad.cxx",
    "vtkQuadraticTetra.cxx",
    "vtkQuadraticTriangle.cxx",
    "vtkQuadraticWedge.cxx",
    "vtkQuadratureSchemeDefinition.cxx",
    "vtkQuadric.cxx",
    "vtkRectilinearGrid.cxx",
    "vtkReebGraph.cxx",
    "vtkReebGraphSimplificationMetric.cxx",
    "vtkSelection.cxx",
    "vtkSelectionNode.cxx",
    "vtkSimpleCellTessellator.cxx",
    "vtkSmoothErrorMetric.cxx",
    "vtkSortFieldData.cxx",
    "vtkSphere.cxx",
    "vtkSpheres.cxx",
    "vtkSphericalPointIterator.cxx",
    "vtkSpline.cxx",
    "vtkStaticCellLinks.cxx",
    "vtkStaticCellLocator.cxx",
    "vtkStaticPointLocator.cxx",
    "vtkStaticPointLocator2D.cxx",
    "vtkStructuredData.cxx",
    "vtkStructuredExtent.cxx",
    "vtkStructuredGrid.cxx",
    "vtkStructuredPoints.cxx",
    "vtkStructuredPointsCollection.cxx",
    "vtkSuperquadric.cxx",
    "vtkTable.cxx",
    "vtkTetra.cxx",
    "vtkTree.cxx",
    "vtkTreeBFSIterator.cxx",
    "vtkTreeDFSIterator.cxx",
    "vtkTreeIterator.cxx",
    "vtkTriQuadraticHexahedron.cxx",
    "vtkTriQuadraticPyramid.cxx",
    "vtkTriangle.cxx",
    "vtkTriangleStrip.cxx",
    "vtkUndirectedGraph.cxx",
    "vtkUniformGrid.cxx",
    "vtkUniformHyperTreeGrid.cxx",
    "vtkUnstructuredGrid.cxx",
    "vtkUnstructuredGridBase.cxx",
    "vtkUnstructuredGridCellIterator.cxx",
    "vtkVertex.cxx",
    "vtkVertexListIterator.cxx",
    "vtkVoxel.cxx",
    "vtkWedge.cxx",
    "vtkXMLDataElement.cxx",
    "vtkAMRDataInternals.cxx",
    "vtkAMRInformation.cxx",
    "vtkNonOverlappingAMR.cxx",
    "vtkOverlappingAMR.cxx",
    "vtkUniformGridAMR.cxx",
    "vtkUniformGridAMRDataIterator.cxx",
};

const commonMathConfigHeaders = &.{};

const commonMathSources = &.{
    "vtkAmoebaMinimizer.cxx",
    "vtkFFT.cxx",
    "vtkFunctionSet.cxx",
    "vtkInitialValueProblemSolver.cxx",
    "vtkMatrix3x3.cxx",
    "vtkMatrix4x4.cxx",
    "vtkPolynomialSolversUnivariate.cxx",
    "vtkQuaternionInterpolator.cxx",
    "vtkRungeKutta2.cxx",
    "vtkRungeKutta4.cxx",
    "vtkRungeKutta45.cxx",
};

const commonMiscConfigHeaders = &.{};

const commonMiscSources = &.{
    "vtkContourValues.cxx",
    "vtkErrorCode.cxx",
    "vtkExprTkFunctionParser.cxx",
    "vtkFunctionParser.cxx",
    "vtkHeap.cxx",
    "vtkPolygonBuilder.cxx",
    "vtkResourceFileLocator.cxx",
};

const commonSystemConfigHeaders = &.{};

const commonSystemSources = &.{
    "vtkClientSocket.cxx",
    "vtkDirectory.cxx",
    "vtkExecutableRunner.cxx",
    "vtkServerSocket.cxx",
    "vtkSocket.cxx",
    "vtkSocketCollection.cxx",
    "vtkTimerLog.cxx",
};

const commonTransformsConfigHeaders = &.{};

const commonTransformsSources = &.{
    "vtkAbstractTransform.cxx",
    "vtkCylindricalTransform.cxx",
    "vtkGeneralTransform.cxx",
    "vtkHomogeneousTransform.cxx",
    "vtkIdentityTransform.cxx",
    "vtkLandmarkTransform.cxx",
    "vtkLinearTransform.cxx",
    "vtkMatrixToHomogeneousTransform.cxx",
    "vtkMatrixToLinearTransform.cxx",
    "vtkPerspectiveTransform.cxx",
    "vtkSphericalTransform.cxx",
    "vtkThinPlateSplineTransform.cxx",
    "vtkTransform.cxx",
    "vtkTransform2D.cxx",
    "vtkTransformCollection.cxx",
    "vtkWarpTransform.cxx",
};

const VtkConfErrors = error{
    ConfFileNotFound,
};

pub fn addVtkCommon(b: *std.Build, dep: *Dependency, target: TargetOpts, optimize: OptimizeOpts) !void {
    var commonCore = b.addStaticLibrary(.{
        .name = "vtkCommonCore",
        .target = target,
        .optimize = optimize,
    });

    var commonSystem = b.addStaticLibrary(.{
        .name = "vtkCommonSystem",
        .target = target,
        .optimize = optimize,
    });

    var commonMath = b.addStaticLibrary(.{
        .name = "vtkCommonMath",
        .target = target,
        .optimize = optimize,
    });

    var commonTransforms = b.addStaticLibrary(.{
        .name = "vtkCommonTransforms",
        .target = target,
        .optimize = optimize,
    });

    var commonMisc = b.addStaticLibrary(.{
        .name = "vtkCommonMisc",
        .target = target,
        .optimize = optimize,
    });

    var commonDataModel = b.addStaticLibrary(.{
        .name = "vtkCommonDataModel",
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

        vtkSys.installConfigHeader(tmp);
        vtkSys.addConfigHeader(tmp);
        //commonCore.addConfigHeader(tmp);
        //commonMisc.addConfigHeader(tmp);
        //commonMath.addConfigHeader(tmp);
        //commonDataModel.addConfigHeader(tmp);
    }

    vtkSys.defineCMacro("KWSYS_NAMESPACE", "vtksys");

    vtkSys.addIncludePath(b.path("include"));
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
                .VTK_HAS_CXXABI_DEMANGLE = 1,
                .VTK_ARRAYDISPATCH_ARRAY_LIST = arrDispatch.result.items,
            },
        );

        commonCore.installConfigHeader(tmp);
        commonCore.addConfigHeader(tmp);
        //commonMath.addConfigHeader(tmp);
        //commonMisc.addConfigHeader(tmp);
        //commonDataModel.addConfigHeader(tmp);
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
    commonCore.addIncludePath(b.path("zig-out/include"));
    commonCore.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonCore.addCSourceFiles(.{
        .root = dep.path(commonCorePath),
        .files = &commonCoreSources,
        .flags = &.{"-std=c++17"},
    });

    commonSystem.defineCMacro("VTK_HAVE_GETSOCKNAME_WITH_SOCKLEN_T", "1");

    commonSystem.linkLibCpp();
    commonSystem.linkLibrary(commonCore);
    commonSystem.addIncludePath(dep.path(commonCorePath));
    commonSystem.addIncludePath(dep.path(commonDataModelPath));
    commonSystem.addIncludePath(dep.path("Utilities/KWIML"));
    commonSystem.addIncludePath(dep.path("Utilities/KWSys"));
    commonSystem.addIncludePath(b.path("include"));
    commonSystem.addIncludePath(b.path("zig-out/include"));
    commonSystem.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonSystem.addCSourceFiles(.{
        .root = dep.path(commonSystemPath),
        .files = commonSystemSources,
        .flags = &.{"-std=c++17"},
    });

    //commonMath.defineCMacro("USE_SIMD", "1");
    commonMath.defineCMacro("kiss_fft_scalar", "double");

    commonMath.linkLibCpp();
    commonMath.linkLibrary(vtkSys);
    commonMath.linkLibrary(commonCore);
    commonMath.addIncludePath(dep.path(commonCorePath));
    commonMath.addIncludePath(dep.path(commonMathPath));
    commonMath.addIncludePath(dep.path(commonDataModelPath));
    commonMath.addIncludePath(dep.path("Utilities/KWIML"));
    commonMath.addIncludePath(dep.path("Utilities/KWSys"));
    commonMath.addIncludePath(b.path("include"));
    commonMath.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonMath.addIncludePath(b.path("zig-out/include"));
    commonMath.addIncludePath(b.path("zig-out/include/vtkkissfft"));
    commonMath.addIncludePath(dep.path(thirdparty.kissFFTPath));
    commonMath.addCSourceFiles(.{
        .root = dep.path(commonMathPath),
        .files = commonMathSources,
        .flags = &.{ "-std=c++17", "-Wno-narrowing" },
    });

    commonTransforms.linkLibCpp();
    commonTransforms.linkLibrary(vtkSys);
    commonTransforms.linkLibrary(commonMath);
    commonTransforms.addIncludePath(dep.path(commonTransformsPath));
    commonTransforms.addIncludePath(dep.path("Utilities/KWIML"));
    commonTransforms.addIncludePath(dep.path("Utilities/KWSys"));
    commonTransforms.addIncludePath(b.path("include"));
    commonTransforms.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonTransforms.addIncludePath(b.path("zig-out/include"));
    commonTransforms.addCSourceFiles(.{
        .root = dep.path(commonTransformsPath),
        .files = commonTransformsSources,
        .flags = &.{ "-std=c++17", "-Wno-narrowing" },
    });

    commonMisc.linkLibCpp();
    commonMisc.linkLibrary(vtkSys);
    commonMisc.linkLibrary(commonMath);
    commonMisc.addIncludePath(dep.path(commonMathPath));
    commonMisc.addIncludePath(dep.path(commonMiscPath));
    commonMisc.addIncludePath(dep.path(commonCorePath));
    commonMisc.addIncludePath(dep.path(commonDataModelPath));
    commonMisc.addIncludePath(dep.path("Utilities/KWIML"));
    commonMisc.addIncludePath(dep.path("Utilities/KWSys"));
    commonMisc.addIncludePath(b.path("include"));
    commonMisc.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonMisc.addIncludePath(b.path("zig-out/include"));
    commonMisc.addIncludePath(b.path("zig-out/include/vtkkissfft"));
    commonMisc.addIncludePath(dep.path(thirdparty.kissFFTPath));
    commonMisc.addIncludePath(dep.path(thirdparty.exprTKPath));
    commonMisc.addCSourceFiles(.{
        .root = dep.path(commonMiscPath),
        .files = commonMiscSources,
        .flags = &.{"-std=c++17"},
    });

    commonDataModel.linkLibCpp();
    commonDataModel.linkLibrary(commonCore);
    commonDataModel.linkLibrary(commonMath);
    commonDataModel.linkLibrary(commonMisc);
    commonDataModel.linkLibrary(commonSystem);
    commonDataModel.addIncludePath(dep.path(commonDataModelPath));
    commonDataModel.addIncludePath(dep.path(commonCorePath));
    commonDataModel.addIncludePath(dep.path(commonMathPath));
    commonDataModel.addIncludePath(dep.path(commonTransformsPath));
    commonDataModel.addIncludePath(dep.path(commonMiscPath));
    commonDataModel.addIncludePath(dep.path(commonSystemPath));
    commonDataModel.addIncludePath(dep.path("Utilities/KWIML"));
    commonDataModel.addIncludePath(b.path("include"));
    commonDataModel.addIncludePath(b.path("include/vtk_typed_arrays"));
    commonDataModel.addIncludePath(b.path("zig-out/include"));
    commonDataModel.addIncludePath(dep.path(thirdparty.kissFFTPath));
    commonDataModel.addIncludePath(dep.path(thirdparty.exprTKPath));
    commonDataModel.addIncludePath(dep.path(thirdparty.pugiXmlPath));
    commonDataModel.addIncludePath(dep.path(thirdparty.pugiXmlPath ++ "vtkpugixml/"));
    commonDataModel.addCSourceFiles(.{
        .root = dep.path(commonDataModelPath),
        .files = commonDataModelSources,
        .flags = &.{"-std=c++17"},
    });

    b.installArtifact(vtkSys);
    b.installArtifact(commonCore);
    b.installArtifact(commonSystem);
    b.installArtifact(commonMisc);
    b.installArtifact(commonMath);
    b.installArtifact(commonDataModel);
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
