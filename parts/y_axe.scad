include <MCAD/stepper.scad>;

use <../libs/openbuilds/bearings/bearing.scad>;
use <../libs/openbuilds/shims_and_spacers/spacer.scad>;
use <../libs/openbuilds/screws/screw.scad>;
use <../libs/openbuilds/hardware/flexible_coupling.scad>;
use <../libs/openbuilds/hardware/lock_collar.scad>;
use <../libs/openbuilds/hardware/acme_lead_screw_nut.scad>;
use <../libs/openbuilds/screws/acme_lead_screw.scad>;
use <../libs/openbuilds/linear_rails/vslot.scad>;
use <../libs/openbuilds/plates/vslot_gantry_plate.scad>;
use <../libs/openbuilds/plates/threaded_rod_plate.scad>;
use <../libs/openbuilds/plates/motor_mount_plate.scad>;
use <../libs/openbuilds/wheels/vwheel.scad>;

use <../helpers/angle_corner_with_screw.scad>;
use <../helpers/end_cap_with_screw.scad>;
use <../helpers/vwheel_with_screw.scad>;

module y_axe_carriage() {
  translate([0, -40, 0]) {
    translate([20, 0, 22]) rotate([0, 0, 180]) universel_v_plate();
    translate([-3, -20, 24]) rotate([0, 0, 90]) motor_mount_plate_nema17();
    translate([0, -7, 27])acme_lead_screw_nut_block_anti_backlash();
    for (x=[30,-30], y=[30,-30]) translate([x, y, 22+3.4]) rotate([0, 0, 0]) vwheel_with_screw(eccentric=(x>0)) xtreme_solid_vwheel();
  }
}

module y_axe_mouvment(h, position) {
  translate([0, h/2, 10]) rotate([90, 0, 0]) vslot20x40(h);
  for(x=[-1,1], y=[-1,1]) {
    translate([20*x, (h/2-10)*y-10*x, 0]) rotate([0, 0, -90*x]) angle_corner_with_screw();
    /*translate([10*x, (h/2+1.5)*y, 10]) rotate([90, 0, 90+90*y]) end_cap_with_screw();*/
  }

  translate([0, -h/2-42, 32.5]) rotate([90, 45, 0]) motor(Nema23, NemaMedium);
  for (a=[0,90,180]) {
    translate([0, -h/2, 32.5]) rotate([-a, 0, 90]) union() {
      translate([-3.2, -33, 0]) rotate([-90, 0, 90]) spacer(40);
      translate([1.5, -33, 0])  rotate([0, -90, 0]) m5_screw(55);
    }
  }
  translate([0, -h/2-10, 32.5]) rotate([90, 0, 0]) flexible_coupling_5x8();
  translate([-40, h/2+3.14, 0]) rotate([90, 0, 0]) threaded_rod_plate_nema23();
  translate([0, h/2, 32.5]) rotate([90, 0, 0]) bearing(688);
  translate([0, h/2-5, 32.5]) rotate([90, 0, 0]) lock_collar();
  translate([0, h/2, 32.5]) rotate([90, 0, 0]) acme_lead_screw(h+20);
  translate([0, -h/2+5, 32.5]) rotate([-90, 0, 0]) lock_collar();
  translate([0, -h/2, 32.5]) rotate([-90, 0, 0]) bearing(688);
  translate([40, -h/2-3.14, 0]) rotate([90, 0, 180]) threaded_rod_plate_nema23();

  translate([0, h/2-position, 0]) y_axe_carriage();
}

module y_axe(width, height, position=0) {
  h=height+40*2;
  w=width-40*2;
  translate([-w/2, 0, 0]) y_axe_mouvment(h, position);
  translate([w/2, 0, 0]) mirror([1]) y_axe_mouvment(h, position);
}
