$fa = 1;
$fs = 0.4;

// lets make it the same layout as the Cheops pyramid
base_cheops=230.3;
height_cheops=146.59;

// scaling factor
factor=2303.3;

// just so we know the actual value - mm/m
mmpm = 1000;

// lets calculate our values in mm
base_mm=base_cheops/factor * mmpm;
height_mm=height_cheops/factor * mmpm;

// we'd like to print with a gap
gap_mm=10;

module pyramid(base_length, height) {
    rotate([0,0,45])
        cylinder(h=height,r1=base_length/2*sqrt(2),r2=0,$fn=4);
}

module slice(base_length, height) {
    epsilon=.1;
    linear_extrude(height = height + 2*epsilon)
        translate([0,0,-epsilon])
            polygon([[0,0],[0,base_length],[-base_length,base_length]]);
}

module quarter(base_length, height) {
    epsilon=.1;
    linear_extrude(height = height + 2*epsilon)
        translate([0,0,-epsilon])
            polygon([[0,0],[0,base_length],[base_length,base_length],[base_length,0]]);
}


// pyramid with quarter and slice removed
difference() {
    pyramid(base_mm, height_mm);
    union() {
        slice(base_mm/2, height_mm);
        quarter(base_mm/2, height_mm);
    };
};

// slice, separated by gap
translate([0,gap_mm,0])
intersection() {
    pyramid(base_mm, height_mm);
    slice(base_mm/2, height_mm);
};

// qarter, separated by gap
translate([gap_mm,gap_mm,0])
intersection() {
    pyramid(base_mm, height_mm);
    quarter(base_mm/2, height_mm);
};