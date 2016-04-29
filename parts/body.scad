use <../libs/openbuilds/linear_rails/vslot.scad>;
use <../libs/openbuilds/plates/joining_plate.scad>;

use <../helpers/angle_corner_with_screw.scad>;
use <../helpers/cube_corner_with_screw.scad>;
use <../helpers/end_cap_with_screw.scad>;
use <../helpers/joining_plate_with_screw.scad>;
use <../helpers/screw_with_tnut.scad>;

module body_corner(use_cube=true) {
  if (use_cube) cube_corner_with_screw(3);
  translate([-40, 20, 0]) rotate([-90, -90, 0]) 90_joining_plate_with_screw();
  translate([20, 20, 60]) rotate([90, 180, 90]) 90_joining_plate_with_screw();
  translate([20, -40, 0]) rotate([0, 180, 0]) 90_joining_plate_with_screw();
}

module body_top(w, h) {
  for (y=[1,-1]) translate([-(w/2)+20, (h/2-10)*y]) rotate([0, 90, 0]) vslot20x20(w-20*2);
  for (x=[1,-1]) translate([(w/2-10)*x, -(h/2)+20]) rotate([0, 90, 90]) vslot20x20(h-20*2);
  for (x=[1,-1], y=[1,-1])
    translate([(w/2-10)*x, (h/2-10)*y, 0]) rotate([90, 0, x > 0 ? (y > 0 ? 0 : -90) : (y > 0 ? 90 : 180)])
      translate([-10, -10, -10]) body_corner();
}

module body_bottom(w, h) {
  for (y=[1,-1]) {
    translate([-(w/2), (h/2-10)*y, -10]) rotate([0, 90, 0]) vslot20x40(w);
    translate([w/2+3, (h/2-10)*y, -20]) rotate([0, 90, 0]) end_cap_with_screw();
    translate([-w/2-3, (h/2-10)*y, -20]) rotate([0, -90, 0]) end_cap_with_screw();
  }
  for (x=[1,-1]) translate([(w/2-10)*x, -(h/2)+20]) rotate([0, 90, 90]) vslot20x20(h-20*2);
  for (x=[1,-1], y=[1,-1])
    translate([(w/2-10)*x, (h/2-10)*y, 0]) rotate([0, 0, x > 0 ? (y > 0 ? 0 : -90) : (y > 0 ? 90 : 180)])
      translate([-10, -10, -10]) body_corner(use_cube=false);

  cy = ceil( (h/2-60) / 250 );
  cd = ((h-80-h_padding*2)/2)/cy;
  for (y=[cd*cy:-cd:cd*-cy]) if(y!=0) {
    translate([-w/2, y, -20]) rotate([0, 90, 0]) vslot20x20(w);
    translate([w/2+3, y, -20]) rotate([0, 90, 0]) end_cap_with_screw();
    translate([-w/2-3, y, -20]) rotate([0, -90, 0]) end_cap_with_screw();
  }
}

module body_side(h, length) {
  for (y=[1,-1]) translate([(h/2-10)*y, -10, -length/2+10]) vslot20x20(length-20);

  cy = ceil( (h/2-60) / 250 );
  cd = ((h-80-h_padding*2)/2)/cy;

  nb=ceil(length/350);
  offset=length/nb;

  for (z=[offset:offset:(nb-1)*offset]) {
    translate([-h/2+10, -20, z-length/2]) {
      translate([10, 10, 0]) rotate([90, 0, 90]) vslot20x20(h-40);
      translate([h-70, 20, -30]) rotate([0, -90, -90]) t_joining_plate_with_screw();
      translate([50, 20, 30]) rotate([180, 90, -90]) t_joining_plate_with_screw();
    }
    for (y=[cd*cy:-cd:cd*-cy]) if(y!=0) {
      translate([y+10, -20, z-length/2+10]) angle_corner_with_screw();
      translate([y+10, -20, z-length/2-10]) rotate([-90, 0, 0]) angle_corner_with_screw();
    }
  }
}

module body_back(w, length) {

}

module body_front(w, length) {

}

w_padding=63.4;
h_padding=40;
module body(width, height, length) {
  w=width+w_padding*2;
  h=height+h_padding*2;
  l=length+150+130;

  translate([0, 0, l]) body_top(w, h);
  translate([-w/2, 0, l/2]) rotate([0, 0, 90]) body_side(h, l);
  translate([0, 0, h/2]) body_back(w, l);
  translate([0, 0, -h/2]) body_front(w, l);
  translate([w/2, 0, l/2]) rotate([0, 0, -90]) body_side(h, l);
  body_bottom(w, h);
}
