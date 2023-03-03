//create dialog for images
Dialog.create("My inputs");
Dialog.addMessage("Select Images for Probe & PumpProbe:");

Dialog.addChoice("Probe Source File:", im_name_list);
Dialog.addChoice("PumpProbe Source File:", im_name_list);

// Finally show the GUI, once all parameters have been added
Dialog.show();

// recover dialog values for Probe & PumpProbe
Probe_str = Dialog.getChoice();
PumpProbe_str = Dialog.getChoice();


//t = getTitle;
//run("Previous Slice [<]");
//run("Previous Slice [<]");
//run("Plot Profile");
//selectWindow(t);
//run("Next Slice [>]");
//run("Plot Profile");
//rename("2Beam-Plot");
//Plot.addFromPlot("Plot of " + t, 0);
//Plot.setStyle(0, "blue,none,1.0,Line");
//Plot.setStyle(1, "green,none,1.0,Line");
//Plot.addLegend("Beam1\nBeam2", "Auto");
//selectWindow("Plot of " + t);
//close();
//selectWindow(t);
//run("Next Slice [>]");
//run("Plot Profile");
//rename("Difference-Plot");
//selectWindow("2Beam-Plot");