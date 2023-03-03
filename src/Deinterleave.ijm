//Take an image series and split it into two separate image sums
//Designed for photothermal imaging, to toggle between a pump image and
//a Pump&Probe image, then sum the two

//TODO: fix the averaging method losing precision over summing

//camera parameters (1px = 3.45x3.45um)
run("Set Scale...", "distance=1 known=3.45 pixel=1 unit=micron global");
//create dialog to help organize multiple images
base_title = getTitle;
im_name_list = getList("image.titles");
Dialog.create("My inputs");
Dialog.addMessage("Select Source File and Label:");
Dialog.addChoice("Source File:", im_name_list);
Dialog.addString("Image Label:", base_title);
Dialog.show();
t = Dialog.getChoice();
label = Dialog.getString();
selectWindow(t);
run("Deinterleave", "how=2 keep"); 
close(t + " #3"); //close any leftovers from odd-numbered stacks
selectWindow(t + " #1"); //pump images (odd frames)
run("Z Project...", "projection=[Sum Slices]");
rename("Pump Sum (" + label + ")");
avg1 = getTitle;
selectWindow(t + " #2"); //pumpProbe images (even frames)
run("Z Project...", "projection=[Sum Slices]");
rename("PumpProbe Sum (" + label + ")");
avg2 = getTitle;
close(t + " #2");
close(t + " #1");
//calculate difference
imageCalculator("Subtract create 32-bit", avg1, avg2);
rename("Difference (" + label + ")");
resultwindow = getTitle;