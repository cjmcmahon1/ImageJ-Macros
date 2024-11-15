//polarization camera 4-view plot
//make selection in top left quadrant
base_title = getTitle;
run("Plot Profile");
rename("Top Left");

//top right selection
selectImage(base_title);
getSelectionCoordinates(x, y);
makeLine(x[0]+1224, y[0], x[1]+1224, y[1]);
run("Plot Profile");
rename("Top Right");

//bottom left selection
selectImage(base_title);
makeLine(x[0], y[0]+1024, x[1], y[1]+1024);
run("Plot Profile");
rename("Bottom Left");

//bottom right selection
selectImage(base_title);
makeLine(x[0]+1224, y[0]+1024, x[1]+1224, y[1]+1024);
run("Plot Profile");
rename("Quadrant Plots");
Plot.setStyle(0, "1f77b4,none,1.0,Line");
Plot.addFromPlot("Top Left", 0);
Plot.setStyle(1, "ff7f0e,none,1.0,Line");
Plot.addFromPlot("Top Right", 0);
Plot.setStyle(2, "2ca02c,none,1.0,Line");
Plot.addFromPlot("Bottom Left", 0);
Plot.setStyle(3, "d62728,none,1.0,Line");

Plot.addLegend("Bottom Right\nTop Left\nTop Right\nBottom Left", "Auto");

selectImage("Top Left");
close()
selectImage("Top Right");
close()
selectImage("Bottom Left");
close()