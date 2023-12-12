(* Define a function to plot the solid of revolution, cylindrical shells, or both, for a given function f over an interval [a, b]. 
   The type of plot (solid, shells, or both) can be specified. 
   The function also calculates the volume of the solid of revolution. *)
plotSolidOfRevolution[f_, a_, b_, theta_, n_, plotType_: "both"] := 
  Module[{dx, vol, cc1, solid, volume, plotElements},

    dx = (b - a)/n;
    vol = N[Pi*Sum[f[a + (i - 1)*dx]^2*dx, {i, 1, n}]];
    volume = NIntegrate[Pi*f[x]^2, {x, a, b}];

    cc1 = Graphics3D[{Blue, Opacity[0.5], 
      Table[Cylinder[{{a + (i - 1)*dx, 0, 0}, {a + i*dx, 0, 0}}, 
        Abs[f[a + (i - 1)*dx]]], {i, 1, n}]}, Boxed -> True];
    
    solid = ParametricPlot3D[{x, f[x]*Cos[y], f[x]*Sin[y]}, {x, a, b}, 
      {y, 0, theta + .01}, PlotStyle -> {Red, Opacity[0.35]}];

    (* Determine which elements to include in the plot based on the plotType argument *)
    plotElements = Switch[plotType,
      "solid", {solid},
      "shells", {cc1},
      _, {cc1, solid}
    ];

    Show[plotElements, AxesLabel -> {"X", "Y", "Z"}, 
      AxesOrigin -> {0, 0, 0}, 
      PlotLabel -> Grid[{{"true volume = ", volume}, {"approximation = ", vol}}], 
      ImageSize -> {350, 350}, PlotRange -> All]
];

(* Example usage: plotSolidOfRevolution[Sqrt, 0, 4, 2*Pi, 10, "solid"] *)
