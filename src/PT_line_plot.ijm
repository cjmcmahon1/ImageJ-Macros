// define plot titles
run("Set Scale...", "distance=1 known=3.45 pixel=1 unit=micron global");
pt_diff = "PumpProbe-(Pump+Probe)";
bkg_sum = "Pump+Probe";
Pump = "Pump";
Probe = "Probe";
PumpProbe = "PumpProbe";
// make line plots based on selection
selectWindow(pt_diff);
run("Restore Selection");
run("Plot Profile");

selectWindow(Pump);
run("Restore Selection");
run("Plot Profile");

selectWindow("Plot of "+pt_diff);
Plot.setStyle(0, "orange,none,1.0,Line");
Plot.addFromPlot("Plot of "+Pump, 0);
Plot.setStyle(1, "green,none,1.0,Line");
Plot.addLegend(pt_diff+"\n"+Pump, "Auto");
//remove old plot
selectWindow("Plot of "+Pump);
close();

//Plot the PumpProbe and Pump+Probe images
selectWindow(PumpProbe);
run("Restore Selection");
run("Plot Profile");
Plot.setStyle(0, "orange,none,1.0,Line");
selectWindow(bkg_sum);
run("Restore Selection");
run("Plot Profile");
selectWindow("Plot of "+PumpProbe);
Plot.addFromPlot("Plot of "+bkg_sum, 0);
Plot.setStyle(1, "blue,none,1.0,Line");
Plot.addLegend(PumpProbe+"\n"+"bkg_sum", "Auto");
//close old plot window
selectWindow("Plot of "+bkg_sum);
close();