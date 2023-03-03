base_img_name=getTitle();
im_name_list = getList("image.titles");
run("Set Scale...", "distance=1 known=3.45 pixel=1 unit=micron global");

Dialog.create("My inputs");
Dialog.addMessage("Select Frames for Probe, Pump, and PumpProbe:");

Dialog.addChoice("Probe Source File:", im_name_list);
Dialog.addNumber("Probe Start Frame", 1);
Dialog.addToSameRow();
Dialog.addNumber("Probe End Frame", 101);
Dialog.addChoice("PumpProbe Source File:", im_name_list);
Dialog.addNumber("PumpProbe Start Frame", 200);
Dialog.addToSameRow();
Dialog.addNumber("PumpProbe End Frame", 300);
Dialog.addChoice("Pump Source File:", im_name_list);
Dialog.addNumber("Pump Start Frame", 600);
Dialog.addToSameRow();
Dialog.addNumber("Pump End Frame", 700);

// Finally show the GUI, once all parameters have been added
Dialog.show();

// recover dialog values for pump, probe, and pumpprobe files & frames
Probe_str = Dialog.getChoice();
Probe_start = Dialog.getNumber();
Probe_end = Dialog.getNumber();

PumpProbe_str = Dialog.getChoice();
PumpProbe_start = Dialog.getNumber();
PumpProbe_end = Dialog.getNumber();

Pump_str = Dialog.getChoice();
Pump_start = Dialog.getNumber();
Pump_end = Dialog.getNumber();

//print(Probe_str);

// Run Z-projections of the three image modalities
selectWindow(Probe_str);
run("Z Project...", "start="+Probe_start+" stop="+Probe_end+" projection=[Sum Slices]");
rename("Probe");

selectWindow(PumpProbe_str);
run("Z Project...", "start="+PumpProbe_start+" stop="+PumpProbe_end+" projection=[Sum Slices]");
rename("PumpProbe");

selectWindow(Pump_str);
run("Z Project...", "start="+Pump_start+" stop="+Pump_end+" projection=[Sum Slices]");
rename("Pump");
 
//add pump and probe image together
imageCalculator("Add create 32-bit", "Probe","Pump");
selectWindow("Result of Probe");
rename("Pump+Probe");

//subtract the combined image from the PumpProbe image
imageCalculator("Subtract create 32-bit", "PumpProbe","Pump+Probe");
selectWindow("Result of PumpProbe");
rename("PumpProbe-(Pump+Probe)");

Dialog.create("Await Input");
Dialog.addMessage("Select a line to plot along");
setTool("line");
Dialog.show();