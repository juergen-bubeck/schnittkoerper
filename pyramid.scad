$fa = 1;
$fs = 0.4;

base=100;
gap=10;

module pyramid(base_length) {
    rotate([0,0,45])
        cylinder(h=base_length,r1=base_length*sqrt(2),r2=0,$fn=4);
}

module slice(base_length) {
    epsilon=.1;
    linear_extrude(height = base_length + 2*epsilon)
        translate([0,0,-epsilon])
            polygon([[0,0],[0,base_length],[-base_length,base_length]]);
}

module quarter(base_length) {
    epsilon=.1;
    linear_extrude(height = base_length + 2*epsilon)
        translate([0,0,-epsilon])
            polygon([[0,0],[0,base_length],[base_length,base_length],[base_length,0]]);
}

radius=base/2;

difference() {
    pyramid(radius);
    union() {
        slice(radius);
        quarter(radius);
    };
};

translate([0,gap,0])
intersection() {
    pyramid(radius);
    slice(radius);
};

translate([gap,gap,0])
intersection() {
    pyramid(radius);
    quarter(radius);
};