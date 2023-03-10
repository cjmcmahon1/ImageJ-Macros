run("Set Scale...", "distance=1 known=3.45 pixel=1 unit=micron global");
t = getTitle;
run("Deinterleave", "how=2 keep");
close(t + " #3"); //close any leftovers from odd-numbered stacks
selectWindow(t + " #1");
run("Z Project...", "projection=[Average Intensity]");
avg1 = getTitle;
selectWindow(t + " #2");
run("Z Project...", "projection=[Average Intensity]");
avg2 = getTitle;
close(t + " #2");
close(t + " #1");
imageCalculator("Subtract create 32-bit", avg1, avg2);
resultwindow = getTitle;
run("Images to Stack", "name=Processed_Stack");
run("Next Slice [>]");