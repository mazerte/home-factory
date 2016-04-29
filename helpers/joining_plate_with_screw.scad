use <../libs/openbuilds/plates/joining_plate.scad>;

use <./screw_with_tnut.scad>;

module 90_joining_plate_with_screw() {
  90_joining_plate();
  for (x=[20,40]) translate([x+10, 40+10, -1]) rotate([0, 0, 90]) screw_with_tnut(8);
  for (y=[0,20]) translate([0+10, y+10, -1]) screw_with_tnut(8);
}

module 2_joining_plate_with_screw() {
  2_joining_plate();
  for (x=[0,20]) translate([x+10, 10, -1]) rotate([0, 0, 90]) screw_with_tnut(8);
}

module t_joining_plate_with_screw() {
  t_joining_plate();
  for (x=[0,20,40]) translate([x+10, 50, -1]) rotate([0, 0, 90]) screw_with_tnut(8);
  for (y=[0,20]) translate([30, y+10, -1]) screw_with_tnut(8);
}
