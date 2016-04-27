include <MCAD/units.scad>

use <../libs/openbuilds/plates/spacer_block.scad>;
use <../libs/openbuilds/screws/screw.scad>;
use <../libs/openbuilds/shims_and_spacers/spacer.scad>;
use <../libs/openbuilds/shims_and_spacers/shim.scad>;
use <../libs/openbuilds/hardware/hex_locknut.scad>;
use <../libs/openbuilds/hardware/eccentric_spacer.scad>;
use <../libs/openbuilds/wheels/vwheel.scad>;

module vwheel_with_screw(eccentric=false) {
  if (eccentric) {
    translate([0, 0, 1/4*inch-10]) rotate([180, 0, 0]) eccentric_spacer();
  } else {
    translate([0, 0, -10]) spacer(1/4*inch);
  }
  translate([0, 0, -15]) children();
  translate([0, 0, -20]) rotate([180, 0, 0]) hex_locknut();
  translate([0, 0, 0]) rotate([180, 0, 0]) m5_screw(25);
}
