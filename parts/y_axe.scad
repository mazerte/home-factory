use <../libs/openbuilds/linear_rails/vslot.scad>;

use <../helpers/angle_corner_with_screw.scad>;
use <../helpers/end_cap_with_screw.scad>;

module y_axe_mouvment(h, position) {
  translate([0, h/2, 10]) rotate([90, 0, 0]) vslot20x40(h);
  for(x=[-1,1], y=[-1,1]) {
    translate([20*x, (h/2-10)*y-10*x, 0]) rotate([0, 0, -90*x]) angle_corner_with_screw();
    translate([10*x, (h/2+1.5)*y, 10]) rotate([90, 0, 90+90*y]) end_cap_with_screw();
  }
}

module y_axe(width, height, position=0) {
  h=height+40*2;
  w=width-40*2;
  translate([-w/2, 0, 0]) y_axe_mouvment(h, position);
  translate([w/2, 0, 0]) mirror([1]) y_axe_mouvment(h, position);
}
