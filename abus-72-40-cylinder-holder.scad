use <utils.scad>;

// dimensions are in mm
epsilon = 0.1;
side_clearance = 0.2;
cylinder_diameter = 9.92;
cylinder_length = 23.96;
groove = 1.98;

cylinder_cutout_diameter = 2 * find_outer_radius(cylinder_diameter / 2) + side_clearance;

key_handle_width = 24.3;
key_blade_width = 8.11;
key_overhang = (key_handle_width - key_blade_width) / 2;
key_thickness = 2.2;
key_handle_length = 21.7;
key_blade_length = 31.8;

bottom_standoff = key_overhang + 5;
block_length = cylinder_length;
block_width = cylinder_cutout_diameter * 1.3;
block_height = cylinder_cutout_diameter * 0.8 + bottom_standoff; 

echo(bottom_standoff);

module cylinder_cutout() {
    translate([block_width / 2, -epsilon/2, cylinder_cutout_diameter/2])
    rotate([-90, 0, 0])
    cylinder(h = cylinder_length + epsilon, d = cylinder_cutout_diameter);
}

module cylinder_holder() {
    difference() {
        translate([0, 0, -bottom_standoff])
        cube([block_width, block_length, block_height]);

        cylinder_cutout();
    }
}

text_thickness = 1;

module label() {
    translate([block_width/2, text_thickness, -cylinder_cutout_diameter * 0.6])
    rotate([90, 0, 0])
    linear_extrude(text_thickness + epsilon)
    text("72/40", size = 3.5, halign = "center", valign = "center");
}

rotate([-90, 0, 0])
difference() {
cylinder_holder();
label();
}

module key() {

    union() {
        translate([(block_width - key_thickness) / 2, 0, 0])
        cube([key_thickness, key_blade_length, key_blade_width]);
        
        translate([(block_width - key_thickness) / 2, key_blade_length - epsilon, -key_overhang])
        cube([key_thickness, key_handle_length + epsilon, key_handle_width]);
    }
}

// key();