use <utils.scad>;

// dimensions are in mm
actual_bible_diameter = 13.80;
side_clearance = 1.5;
bible_cutout_diameter = 2 * find_outer_radius(actual_bible_diameter/2) + side_clearance;

echo(bible_cutout_diameter);
bible_length = 22.70;

module bible(diameter, length) {
    rotate([-90,0,0])
        cylinder(h = length, d = diameter);
}

key_handle_width = 24.3;
key_blade_width = 8.11;
key_overhang = (key_handle_width - key_blade_width) / 2;

bottom_standoff = key_overhang + 5;
block_length = bible_length * 0.9;
block_width = bible_cutout_diameter * 1.3;
block_height = bible_cutout_diameter * 0.6 + bottom_standoff;

module bible_cutout() {
    translate([block_width / 2,
    (block_length - bible_length) / 2,
    bible_cutout_diameter / 2])
        bible(bible_cutout_diameter, bible_length);
}

epsilon = 0.1;
text_thickness = 0.5;

module bible_holder() {
    difference() {
        translate([0, 0, -bottom_standoff])
            cube([block_width, block_length, block_height]);
            
        bible_cutout();
    }   
}

module label() {
    translate([block_width/2, epsilon, -bible_cutout_diameter * 0.6])
    rotate([90, 0, 0])
    linear_extrude(text_thickness + epsilon)
    text("72/40", size = 5, halign = "center", valign = "center");
}

union() {
    bible_holder();
    label();
}