//create dialog for images
Dialog.create("My inputs");
Dialog.addMessage("Select Images for Intensity and QuadView");

Dialog.addChoice("Intensity Source File:", im_name_list);
Dialog.addChoice("QuadView Source File:", im_name_list);

// Finally show the GUI, once all parameters have been added
Dialog.show();

// recover dialog values for Probe & PumpProbe
int_str = Dialog.getChoice();
quad_str = Dialog.getChoice();

selectImage(quad_str);
makeRectangle(0, 0, 1224, 1024);
run("Duplicate...", "title="+int_str+"_phase1");

selectImage(quad_str);
makeRectangle(0, 1024, 1224, 1024);
run("Duplicate...", "title="+int_str+"_phase2");

run("Image Expression Parser (Macro)", "expression=abs(A-B) a="+quad_str+"_phase1 b="+quad_str+"_phase2");

//setTool("line");
makeLine(499, 577, 786, 577);
makeLine(804, 652, 804, 652);
makeLine(524, 575, 772, 575);
