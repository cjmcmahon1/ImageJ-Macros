//create dialog for images

px_size = "3.45";
im_magnification = "20";
quad_magnification = "10";
scale_params = "distance="+im_magnification+" known=1 pixel="+px_size+" unit=micron";
quad_scale_params = "distance="+quad_magnification+" known=1 pixel="+px_size+" unit=micron";
base_title = getTitle;
im_name_list = getList("image.titles");
Dialog.create("My inputs");
Dialog.addMessage("Select Images for Intensity and QuadView");

Dialog.addChoice("Intensity Source File:", im_name_list);
Dialog.addChoice("QuadView Source File:", im_name_list);

// Finally show the GUI, once all parameters have been added
Dialog.show();

// recover dialog values for Probe & PumpProbe
int_str = Dialog.getChoice();
quad_str = Dialog.getChoice();
x = 0; y = 0;

selectImage(quad_str);
run("Set Scale...", quad_scale_params);
quad_rename = substring(quad_str,0,lengthOf(quad_str)-4);
run("Duplicate...", "title="+quad_rename);

rename(quad_rename);
makeRectangle(0, 0, 1224, 1024);
phase1_name = quad_rename+"_phase1";
run("Duplicate...", "title="+phase1_name);

selectImage(quad_rename);
//choose the bottom right quadrant
makeRectangle(1224, 1024, 1224, 1024);
//makeRectangle(1024, 2048, 1224, 1024);
phase2_name = quad_rename+"_phase2"
run("Duplicate...", "title="+phase2_name);

//subtract_params = "expression=abs(A-B) a=5nm-530led-pol_2024-11-14T17-53-50.596_phase1 b=5nm-530led-pol_2024-11-14T17-53-50.596_phase2 c=None d=None e=None f=None"
subtract_params = "expression=abs(A-B) a="+phase1_name+" b="+phase2_name+" c=None d=None e=None";
//run("Image Expression Parser (Macro)", subtract_params);
run("Image Expression Parser (Macro)", subtract_params);
subtract_str = quad_str + "_subtracted";
rename(subtract_str);
run("Set Scale...", quad_scale_params);

selectImage(subtract_str);
waitForUser("Selection", "Make a Line Selection");
getSelectionCoordinates(x, y);

//make line plots based on user selection
selectImage(subtract_str);
makeLine(x[0], y[0], x[1], y[1]);
run("Plot Profile");
rename("Darkfield");
//compare selection from the phase image to the intensity image
selectImage(int_str);
run("Set Scale...", scale_params);
makeLine(2*x[0], 2*y[0], 2*x[1], 2*y[1]);
run("Plot Profile");
rename("Intensity");
Plot.setStyle(0, "1f77b4,none,1.0,Line");
Plot.addFromPlot("Darkfield", 0);
Plot.setStyle(1, "ff7f0e,none,1.0,Line");
Plot.addLegend("Intensity\nDarkfield", "Auto");
selectImage("Darkfield");
close()

selectImage(phase1_name);
close();
selectImage(phase2_name);
close();

selectImage(quad_rename);
makeLine(x[0], y[0], x[1], y[1]);
//plot all 4 quadrants as well, to compare (using Polcam-wuad-plot.ijm)

run("Plot Profile");
rename("Top Left");

//top right selection
selectImage(quad_rename);
getSelectionCoordinates(x, y);
makeLine(x[0]+1224, y[0], x[1]+1224, y[1]);
run("Plot Profile");
rename("Top Right");

//bottom left selection
selectImage(quad_rename);
makeLine(x[0], y[0]+1024, x[1], y[1]+1024);
run("Plot Profile");
rename("Bottom Left");

//bottom right selection
selectImage(quad_rename);
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

selectImage("Top Left");
close()
selectImage("Top Right");
close()
selectImage("Bottom Left");
close()


// end polcam-quad-plot.ijm

Plot.addFromPlot("Intensity", 0);
Plot.setStyle(4, "9467bd,none,1.0,Line");
Plot.addLegend("Bottom Right\nTop Left\nTop Right\nBottom Left\nIntensity", "Auto");

selectImage(quad_rename);
close()