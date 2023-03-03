pt_diff = "Difference-Plot";
plot_2beam = "2Beam-Plot";
stack = "Processed_Stack";
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

selectWindow(plot_2beam);
saveAs("Tiff", save_dir+plot_2beam);
saveAs("Jpeg", save_dir+plot_2beam);
close();

selectWindow(stack);
saveAs("Tiff", save_dir+stack);
close();