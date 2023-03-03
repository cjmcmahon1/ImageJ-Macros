pt_diff = "PumpProbe-(Pump+Probe)";
bkg_sum = "Pump+Probe";
Pump = "Pump";
Probe = "Probe";
PumpProbe = "PumpProbe";
//open dialog to select a save directory
Dialog.create("Save Dialog");
Dialog.addMessage("Select Save Folder");
Dialog.addDirectory("Save Directory", "~")
Dialog.show();
save_dir = Dialog.getString();
// save all files
selectWindow(pt_diff);
saveAs("Tiff", save_dir+pt_diff);
saveAs("Jpeg", save_dir+pt_diff);
close();

selectWindow(bkg_sum);
saveAs("Tiff", save_dir+bkg_sum);
saveAs("Jpeg", save_dir+bkg_sum);
close();

selectWindow(Pump);
saveAs("Tiff", save_dir+Pump);
saveAs("Jpeg", save_dir+Pump);
close();

selectWindow(Probe);
saveAs("Tiff", save_dir+Probe);
saveAs("Jpeg", save_dir+Probe);
close();

selectWindow(PumpProbe);
saveAs("Tiff", save_dir+PumpProbe);
saveAs("Jpeg", save_dir+PumpProbe);
close();

selectWindow("Plot of "+pt_diff);
saveAs("Tiff", save_dir+"Plot of "+pt_diff);
saveAs("Jpeg", save_dir+"Plot of "+pt_diff);
close();

selectWindow("Plot of "+PumpProbe);
saveAs("Tiff", save_dir+"Plot of "+PumpProbe);
saveAs("Jpeg", save_dir+"Plot of "+PumpProbe);
close();