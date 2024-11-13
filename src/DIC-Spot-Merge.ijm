//Script to merge the 2 spots from a DIC image into a single spot
//before running: draw a line between the center of the two spots
//uses the algorithm (a+b) - abs(a-b) where:
//a: DIC spot 1 shifted to center of displacement vector
//b: DIC spot 2 shifted to same position

//global variables
base_img_title = getTitle();
dup1_title = "tmp_duplicate1";
dup2_title = "tmp_duplicate2";

//get the coordinates of a separation vector between the two spots
if ( selectionType() < 0 ) exit( "Line selection required!" );
getSelectionCoordinates( x, y );
x_separation = x[1] - x[0];
y_separation = y[1] - y[0];
print("x_separation: "+x_separation);
print("y_separation: "+y_separation);

//Create shifted dupliucates of DIC image
run("Duplicate...", "title="+dup1_title+" ignore");
selectWindow(base_img_title);
run("Duplicate...", "title="+dup2_title+" ignore");

//translate first duplicate
selectWindow(dup1_title); 
translate1_arg = "x="+round(x_separation / 2)+" y="+round(y_separation/2);
run("Translate...", translate1_arg+" interpolation=None");

//translate second duplicate
selectWindow(dup2_title); 
translate2_arg = "x="+round(-x_separation / 2)+" y="+round(-y_separation/2);
run("Translate...", translate2_arg+" interpolation=None");

//add duplicates for (a+b)
imageCalculator("Add create 32-bit", dup1_title, dup2_title);
selectWindow("Result of "+dup1_title);
rename("a+b");

//subtract duplicates for abs(a-b)
imageCalculator("Subtract create 32-bit", "tmp_duplicate1","tmp_duplicate2");
selectWindow("Result of "+dup1_title);
rename("abs(a-b)");
run("Abs"); //take absolute value

//close the duplicate images
selectWindow(dup2_title); 
close();
selectWindow(dup1_title); 
close();

//subtract the remaining products
imageCalculator("Subtract create 32-bit", "a+b","abs(a-b)");
selectWindow("Result of a+b");
rename("Merged Image");