# VTK Porting to Zig Build System

This README tracks the progress of porting various VTK modules to the Zig build system.

## Progress Tracking

- [ ] **VTK Common**  
    - [x] **VTK Common Core**  
    - [x] **VTK Common DataModel**
    - [x] **VTK Common Math**
    - [x] **VTK Common Color**
- [ ] **VTK IO**  
    - [ ] **VTK I/O XML**  
    - [ ] **VTK I/O Legacy**  
    - [ ] **VTK I/O Image**  
    - [ ] **VTK I/O Geometry**
- [ ] **VTK Filters**
	- [ ] **VTK Filters CellGrid**
	- [ ] **VTK Filters Core**
	- [ ] **VTK Filters Extraction**
	- [ ] **VTK Filters FlowPaths**
	- [ ] **VTK Filters General**
	- [ ] **VTK Filters Generic**
	- [ ] **VTK Filters Geometry**
	- [ ] **VTK Filters GeometryPreview**
	- [ ] **VTK Filters Hybrid**
	- [ ] **VTK Filters HyperTree**
	- [ ] **VTK Filters Imaging**
	- [ ] **VTK Filters Modeling**
	- [ ] **VTK Filters OpenTURNS**
	- [ ] **VTK Filters Parallel**
	- [ ] **VTK Filters ParallelDIY2**
	- [ ] **VTK Filters ParallelFlowPaths**
	- [ ] **VTK Filters ParallelGeometry**
	- [ ] **VTK Filters ParallelImaging**
	- [ ] **VTK Filters ParallelMomentInvariants**
	- [ ] **VTK Filters ParallelMPI**
	- [ ] **VTK Filters ParallelStatistics**
	- [ ] **VTK Filters ParallelVerdict**
	- [ ] **VTK Filters Points**
	- [ ] **VTK Filters Programmable**
	- [ ] **VTK Filters Python**
	- [ ] **VTK Filters Reduction**
	- [ ] **VTK Filters ReebGraph**
	- [ ] **VTK Filters Selection**
	- [ ] **VTK Filters SMP**
	- [ ] **VTK Filters Sources**
	- [ ] **VTK Filters Statistics**
	- [ ] **VTK Filters Tensor**
	- [ ] **VTK Filters Texture**
	- [ ] **VTK Filters Topology**
	- [ ] **VTK Filters Verdict**
- [ ] **VTK Rendering**
    - [ ] **VTK Rendering CellGrid**
	- [ ] **VTK Rendering Context2D**
	- [ ] **VTK Rendering ContextOpenGL2**
	- [ ] **VTK Rendering Core**
	- [ ] **VTK Rendering External**
	- [ ] **VTK Rendering FFMPEGOpenGL2**
	- [ ] **VTK Rendering FreeType**
	- [ ] **VTK Rendering FreeTypeFontConfig**
	- [ ] **VTK Rendering GL2PSOpenGL2**
	- [ ] **VTK Rendering HyperTreeGrid**
	- [ ] **VTK Rendering Image**
	- [ ] **VTK Rendering Label**
	- [ ] **VTK Rendering LICOpenGL2**
	- [ ] **VTK Rendering LOD**
	- [ ] **VTK Rendering Matplotlib**
	- [ ] **VTK Rendering OpenGL2**
	- [ ] **VTK Rendering OpenVR**
	- [ ] **VTK Rendering OpenXR**
	- [ ] **VTK Rendering OpenXRRemoting**
	- [ ] **VTK Rendering Parallel**
	- [ ] **VTK Rendering ParallelLIC**
	- [ ] **VTK Rendering PythonContext2D**
	- [ ] **VTK Rendering Qt**
	- [ ] **VTK Rendering RayTracing**
	- [ ] **VTK Rendering SceneGraph**
	- [ ] **VTK Rendering Tk**
	- [ ] **VTK Rendering UI**
	- [ ] **VTK Rendering Volume**
	- [ ] **VTK Rendering VolumeAMR**
	- [ ] **VTK Rendering VolumeOpenGL2**
	- [ ] **VTK Rendering VR**
	- [ ] **VTK Rendering VtkJS**
	- [ ] **VTK Rendering WebGPU**
	- [ ] **VTK Rendering ZSpace**
- [ ] **VTK Interaction**
    - [ ] **VTK Interaction Style**
    - [ ] **VTK Interaction Image** 
    - [ ] **VTK Interaction Widgets** 
- [ ] **VTK Imaging**
    - [ ] **VTK Imaging Core**  
    - [ ] **VTK Imaging Color**  
    - [ ] **VTK Imaging Morphological**  
- [ ] **VTK Parallel MPI**  
- [ ] **VTK Parallel Core**  
- [ ] **VTK Views**
    - [ ] **VTK Views Context2D**  
    - [ ] **VTK Views Core**
    - [ ] **VTK Views Infovis**
    - [ ] **VTK Views Qt**
- [ ] **VTK Charts Core**  
- [ ] **VTK Accelerators VTKm** 
- [ ] **VTK Utilities** 
    - [ ] **vtkkwiml**  
    - [x] **vtksys**  
    - [ ] **vtkmetaio**

## Instructions

Run
```
zig build
```
