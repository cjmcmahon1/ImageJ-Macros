//create dialog for images

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
quad_rename = substring(quad_str,0,lengthOf(quad_str)-4);
run("Duplicate...", "title="+quad_rename);

rename(quad_rename);
makeRectangle(0, 0, 1224, 1024);
run("Duplicate...", "title="+quad_rename+"_phase1");

selectImage(quad_rename);
//choose the bottom right quadrant
makeRectangle(1224, 1024, 1224, 1024);
//makeRectangle(1024, 2048, 1224, 1024);
run("Duplicate...", "title="+quad_rename+"_phase2");

selectImage(quad_rename);
close()

run("Image Expression Parser (Macro)", "expression=abs(A-B) a="+quad_rename+"_phase1 b="+quad_rename+"_phase2");
subtract_str = quad_str + "_subtracted"
rename(subtract_str)

selectImage(quad_rename+"_phase1");
close()

selectImage(quad_rename+"_phase2");
close()

selectImage(subtract_str);
waitForUser("Selection", "Make a Line Selection");
//compare selection from the phase image to the intensity image
getSelectionCoordinates(x, y);
selectImage(int_str);
makeLine(2*x[0], 2*y[0], 2*x[1], 2*y[1]);

