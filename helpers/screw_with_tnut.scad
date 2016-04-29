use <../libs/openbuilds/hardware/tnut.scad>;
use <../libs/openbuilds/screws/screw.scad>;

module screw_with_tnut(length=8) {
  translate([0, 0, 6]) rotate([180, 0, 0]) m5_screw(length);
  translate([-5, -8.44, 6-length-1]) tnut();
}
