use <../libs/openbuilds/linear_rails/vslot.scad>;

module x_axe(w, position=0) {
  translate([-w/2+80, 0, 40+3.14]) rotate([0, 90, 0]) {
    translate([0, 10, 0])  vslot20x40(w-160);
    translate([0, -10, 0]) vslot20x40(w-160);
  }
}
