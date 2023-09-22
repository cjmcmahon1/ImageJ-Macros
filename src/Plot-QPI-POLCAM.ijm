//plot a phase image stack with a line plot for quicker visualization
magnification = 40;
title = getTitle(); 
plot = "plot_"+title;
df_plot = "df_"+title;
int_plot = "intensity_"+title";
run("Set Scale...", "distance="+magnification+" known=3.45 unit=micron");
//plot 1st line (phase)
setSlice(1);
run("Plot Profile");
rename(plot);
Plot.setStyle(0, "#1f77b4,none,1.0,Line");
//plot 2nd line (darkfield)
selectImage(title);
setSlice(2);
run("Plot Profile");
rename(df_plot);
selectImage(plot);
Plot.addFromPlot(df_plot, 0);
Plot.setStyle(1, "#ff7f0e,none,1.0,Line");
//plot 3rd line (intensity)
selectImage(title);
setSlice(3);
run("Plot Profile");
rename(int_plot);
selectImage(plot);
Plot.addFromPlot(int_plot, 0);
Plot.setStyle(2, "#2ca02c,none,1.0,Line");
Plot.addLegend("Phase\nDarkfield\nBrightfield", "Auto");
//close unneeded windows
selectImage(df_plot);
close();
selectImage(int_plot);
close();