$fa = 1;
$fs = 0.4;


// lets calculate our values in mm
// we use a cone as the basic shape, so lets call it radius
radius_mm=50;
height_mm=60;

// we'd like to print with a gap
gap_mm=10;


module hex_pyramid(radius, height) {
    rotate([0,0,30])
        cylinder(h=height,r1=radius,r2=0,$fn=6);
}

module hex_slice(base_length, height) {
    epsilon=.1;
    linear_extrude(height = height + 2*epsilon)
        translate([0,0,-epsilon])
            polygon([[0,0],[0,base_length],[sin(60)*base_length,cos(60)*base_length]]);
}



// pyramid with quarter and slice removed
difference() {
    hex_pyramid(radius_mm, height_mm);
    hex_slice(radius_mm, height_mm);
};

// slice, separated by gap
translate([gap_mm,gap_mm*2,0])
intersection() {
    hex_pyramid(radius_mm, height_mm);
    hex_slice(radius_mm, height_mm);
};
