//setTool("rectangle");
makeRectangle(104, 8, 1118, 1020);
id = getImageID(); 
title = getTitle(); 
getLocationAndSize(locX, locY, sizeW, sizeH); 
width = getWidth(); 
height = getHeight(); 
qWidth = width / 2; 
qHeight = height / 2; 
q0 = "0_degrees_"+title;
q45 = "45_degrees_"+title;
q135 = "135_degrees_"+title;
q90 = "90_degrees_"+title;

num = "numerator_"+title;
denom = "denominator_"+title;
phase = "phase_"+title;
//split image into 4 quadrants [[0, -45],[45, 90]]
makeRectangle(0, 0, qWidth, qHeight);
run("Duplicate...", "title="+q0);
selectWindow(title);
makeRectangle(qWidth, qHeight, 2*qWidth, 2*qHeight);
run("Duplicate...", "title="+q90);

selectWindow(title);
makeRectangle(0, qHeight, qWidth, 2*qHeight);
run("Duplicate...", "title="+q45);

selectWindow(title);
makeRectangle(qWidth, 0, 2*qWidth, qHeight);
run("Duplicate...", "title="+q135);
//create intensity image (sum all the images)

//create numerator and denominator images
//Ψ(ρ)=atan[(I(pi/4)-I(3pi/4)/(I(0) - I(pi/2)]
//from Cui et al. 2022 eq 4
//https://doi.org/10.1364/OE.472373
imageCalculator("Subtract create 32-bit", q45, q135);
selectImage("Result of "+q45);
rename(num);
imageCalculator("Subtract create 32-bit", q0, q90);
selectImage("Result of "+q0);
rename(denom);
//close individual images
selectImage(q0);
close();
selectImage(q45);
close();
selectImage(q135);
close();
selectImage(q90);
close();


//convert images to arrays to speed up atan2()
selectImage(num);
w = getWidth();
h = getHeight();

UArray=newArray(w*h);
QArray=newArray(w*h); 

selectImage(num);
for (y=0; y<h; y++) {
for (x=0; x<w; x++) {
UArray[y+(w*x)]=getPixel(x, y);
}
}

selectImage(denom);
for (y=0; y<h; y++) {
for (x=0; x<w; x++) {
QArray[y+(w*x)]=getPixel(x, y);
}
}

newImage(phase, "32-bit", w, h, 1);
for (y=0; y<h; y++) {
for (x=0; x<w; x++) {
setPixel(x, y, 0.5*atan2(UArray[y+(w*x)],QArray[y+(w*x)]));
}
}
updateDisplay();

run("Calibration Bar...", "location=[Upper Right] fill=White label=Black number=5 decimal=0 font=12 zoom=1.3 bold overlay");
