use <../libs/openbuilds/brackets/cube_corner.scad>;
use <../libs/openbuilds/hardware/tnut.scad>;
use <../libs/openbuilds/screws/screw.scad>;

module cube_corner_with_screw(nb=3, use_tnut=false) {
  cube_corner();
  a=[[-90, 0, 0], [-90, 0, -90], [0, -180, 0]];
  for (i=[0:nb-1]) {
    translate([10, 10, 10]) rotate(a[i]) union() {
      translate([0, 0, -6]) rotate([180, 0, 0]) m5_screw(8);
      if (use_tnut) translate([-5, -8.44, -15]) tnut();
    }
  }
}
