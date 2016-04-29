use <../libs/openbuilds/linear_rails/vslot.scad>;
use <../libs/openbuilds/plates/joining_plate.scad>;

use <../helpers/angle_corner_with_screw.scad>;
use <../helpers/cube_corner_with_screw.scad>;
use <../helpers/joining_plate_with_screw.scad>;
use <../helpers/screw_with_tnut.scad>;

module body_corner() {
  cube_corner_with_screw(3);
  translate([-40, 20, 0]) rotate([-90, -90, 0]) 90_joining_plate_with_screw();
  translate([20, 20, 60]) rotate([90, 180, 90]) 90_joining_plate_with_screw();
  translate([20, -40, 0]) rotate([0, 180, 0]) 90_joining_plate_with_screw();
}

module body_top(w, h) {
  for (y=[1,-1]) translate([-(w/2)+20, (h/2-10)*y]) rotate([0, 90, 0]) vslot(w-20*2);
  for (x=[1,-1]) translate([(w/2-10)*x, -(h/2)+20]) rotate([0, 90, 90]) vslot(h-20*2);
  for (x=[1,-1], y=[1,-1])
    translate([(w/2-10)*x, (h/2-10)*y, 0]) rotate([90, 0, x > 0 ? (y > 0 ? 0 : -90) : (y > 0 ? 90 : 180)])
      translate([-10, -10, -10]) body_corner(3);
}

module body_bottom(w, h) {
  for (y=[1,-1]) translate([-(w/2)+20, (h/2-10)*y]) rotate([0, 90, 0]) vslot(w-20*2);
  for (x=[1,-1]) translate([(w/2-10)*x, -(h/2)+20]) rotate([0, 90, 90]) vslot(h-20*2);
  for (x=[1,-1], y=[1,-1])
    translate([(w/2-10)*x, (h/2-10)*y, 0]) rotate([0, 0, x > 0 ? (y > 0 ? 0 : -90) : (y > 0 ? 90 : 180)])
      translate([-10, -10, -10]) body_corner(3);
}

module body_side(h, length) {
  for (y=[1,-1]) translate([(h/2-10)*y, -10, -length/2+10]) rotate([0, 0, 0]) vslot(length-20);
}

module body_back(w, length) {

}

module body_front(w, length) {

}

module body(w, h, length) {
  translate([0, 0, length]) body_top(w, h);
  translate([-w/2, 0, length/2]) rotate([0, 0, 90]) body_side(h, length);
  translate([0, 0, h/2]) body_back(w, length);
  translate([0, 0, -h/2]) body_front(w, length);
  translate([w/2, 0, length/2]) rotate([0, 0, -90]) body_side(h, length);
  body_bottom(w, h);
}
