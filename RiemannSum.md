## Left Riemann Sum in 3D Visualization

This Mathematica code estimates the area under the curve for a given function. The example provided within the code is for the function `sin(x)` over the interval `[0, 2π]`. Below is an image generated after running the code in Mathematica, showcasing a 3D visualization of the Left Riemann Sum for `sin(x)` using 30 rectangles.

![Left Riemann sum for sin(x) taking 30 rectangles](https://github.com/Reben80/3DPrintCalculus/blob/main/Reimann_Sum.jpg)

### Mathematica Code

The following Mathematica code snippet creates a 3D plot of the Left Riemann Sum for a specified function. It demonstrates estimating the area under the `sin(x)` curve from `0` to `2π`. The code includes an option to overlay the plot of the function itself, enhancing the visual understanding of the approximation process.

```mathematica
(* Function to create a 3D plot of the Left Riemann Sum for a given function *)
LeftRiemannSum3D[f_, {a_, b_}, n_, depth_, plotFunction_ : True] := Module[
  {
    dx, prisms, functionPlot, combinedPlot, x
  },
  dx = (b - a)/n; (* Calculate the width of each subinterval *)
  
  prisms = Table[
    {Opacity[0.5], Blue, Cuboid[{0, a + i*dx, 0}, {depth, a + (i + 1)*dx, f[a + i*dx]}]}, 
    {i, 0, n - 1}
  ]; (* Create the prisms representing the Riemann Sum *)
  
  If[plotFunction, 
    functionPlot = Plot3D[f[x], {y, 0, depth}, {x, a, b}, PlotStyle -> Opacity[0.3], Mesh -> None];
    combinedPlot = Show[functionPlot, Graphics3D[prisms], PlotRange -> {{0, depth}, {a, b}, All}, BoxRatios -> {0.1, 1, 1}], 
    combinedPlot = Show[Graphics3D[prisms], PlotRange -> {{0, depth}, {a, b}, All}, BoxRatios -> {0.1, 1, 1}]
  ]; (* Conditionally plot the function alongside the prisms *)
  
  combinedPlot
];

(* Example usage of the function to plot the Left Riemann Sum of Sin from 0 to 2*Pi *)
(* and then export the plot as an STL file for 3D printing *)
myPlot = LeftRiemannSum3D[Sin, {0, 2*Pi}, 30, 0.1, False];
Export["sinPlot.stl", myPlot];
