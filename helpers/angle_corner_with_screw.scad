use <../libs/openbuilds/brackets/angle_corner.scad>;
use <../libs/openbuilds/hardware/tnut.scad>;
use <../libs/openbuilds/screws/screw.scad>;

module angle_corner_with_screw(use_tnut=true) {
  angle_corner();
  for (a=[0,-90]) {
    translate([0, 0, a < 0 ? 20 : 0]) rotate([a, 0, 0]) union() {
      translate([-10, 10, 4]) rotate([180, 0, 0]) m5_screw(8);
      if (use_tnut) translate([-15, 1.5, -5]) tnut();
    }
  }
}
