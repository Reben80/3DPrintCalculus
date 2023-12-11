(* Function to create a 3D plot of the Left Riemann Sum for a given function *)
LeftRiemannSum3D[f_, {a_, b_}, n_, depth_, plotFunction_ : True] := 
  Module[{dx, prisms, functionPlot, combinedPlot, x},
    (* Calculate the width of each subinterval *)
    dx = (b - a)/n;

    (* Create the prisms representing the Riemann Sum *)
    prisms = Table[{Opacity[0.5], Blue, 
                    Cuboid[{0, a + i*dx, 0}, {depth, a + (i + 1)*dx, f[a + i*dx]}]}, 
                    {i, 0, n - 1}];

    (* Conditionally plot the function alongside the prisms *)
    If[plotFunction, 
       functionPlot = Plot3D[f[x], {y, 0, depth}, {x, a, b}, 
                             PlotStyle -> Opacity[0.3], Mesh -> None];
       combinedPlot = Show[functionPlot, Graphics3D[prisms], 
                           PlotRange -> {{0, depth}, {a, b}, All}, 
                           BoxRatios -> {0.1, 1, 1}], 
       combinedPlot = Show[Graphics3D[prisms], 
                           PlotRange -> {{0, depth}, {a, b}, All}, 
                           BoxRatios -> {0.1, 1, 1}]
    ];
    combinedPlot
  ];

(* Example usage of the function to plot the Left Riemann Sum of Sin from 0 to 2*Pi *)
(* and then export the plot as an STL file *)
myPlot = LeftRiemannSum3D[Sin, {0, 2*Pi}, 30, 0.1, False];
Export["sinPlot.stl", myPlot];
