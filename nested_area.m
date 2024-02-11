ClearAll[divideAndShade3DOnlyRed];
divideAndShade3DOnlyRed[coords_, size_, depth_, n_] := 
  Module[{half = size/2, shaded, bottomRight, thickness = depth}, 
   If[n == 0, Return[{}]];
   shaded = 
    Cuboid[coords, 
     coords + {half, half, 
       thickness}];(*Create depth only for shaded (red) area*)
   bottomRight = 
    If[n > 1, 
     divideAndShade3DOnlyRed[coords + {half, half, 0}, half, 
      thickness, n - 1], {}];
   Flatten[{{Red, shaded}, bottomRight}]];

Graphics3D[
 divideAndShade3DOnlyRed[{0, 0, 0}, 200, 10, 
  5],(*Adjust'10' to change the depth as needed*)
 PlotRange -> {{0, 200}, {0, 200}, {0, 
    10}},(*Ensure PlotRange accommodates the new depth*)Axes -> True]
