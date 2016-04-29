include <../libs/openbuilds/utils/colors.scad>;

include <MCAD/stepper.scad>;

use <../libs/openbuilds/bearings/bearing.scad>;
use <../libs/openbuilds/brackets/end_cap.scad>;
use <../libs/openbuilds/linear_rails/vslot.scad>;
use <../libs/openbuilds/plates/threaded_rod_plate.scad>;
use <../libs/openbuilds/plates/joining_plate.scad>;
use <../libs/openbuilds/plates/vslot_gantry_plate.scad>;
use <../libs/openbuilds/hardware/acme_lead_screw_nut.scad>;
use <../libs/openbuilds/hardware/flexible_coupling.scad>;
use <../libs/openbuilds/hardware/lock_collar.scad>;
use <../libs/openbuilds/screws/acme_lead_screw.scad>;
use <../libs/openbuilds/shims_and_spacers/spacer.scad>;
use <../libs/openbuilds/screws/screw.scad>;
use <../libs/openbuilds/wheels/vwheel.scad>;

use <../helpers/angle_corner_with_screw.scad>;
use <../helpers/cube_corner_with_screw.scad>;
use <../helpers/screw_with_tnut.scad>;
use <../helpers/vwheel_with_screw.scad>;
use <../helpers/joining_plate_with_screw.scad>;

use <./build_plate/base.scad>;

max_size=500;

module z_axe_plate(w, h) {
  nb_x = floor(w/(max_size+1))+1; // add some renfort when it's max than max_size
  nb_y = floor(h/(max_size+1))+1; // add some renfort when it's max than max_size
  dx = (w-20)/nb_x;
  dy = (h-20)/nb_y;

  build_plate_base(w, h, renfort=false, max_size=max_size);

  // Fixations
  for (x=[1:nb_x]) {
    translate([-(w/2)+dx*x-dx/2-40, h/2+4, -30])  rotate([90, 0, 0]) union() {
      translate([10, 30, 5]) rotate([180, 0, 90]) screw_with_tnut();
      cross_joining_plate();
      translate([90, 30, 5]) rotate([180, 0, 90]) screw_with_tnut();
    }
    translate([-(w/2)+dx*x-dx/2-40, -h/2, -30]) rotate([90, 0, 0]) union() {
      translate([10, 30, -1]) rotate([0, 0, 90]) screw_with_tnut();
      cross_joining_plate();
      translate([90, 30, -1]) rotate([0, 0, 90]) screw_with_tnut();
    }
  }

  // Lead screw nuts
  module lead_screw_fixing_block() {
    union() {
      translate([0, 0, -3.20]) rotate([0, 0, 90])   acme_lead_screw_nut_block();
      translate([10, -20, 20]) rotate([90, -90, 0]) angle_corner_with_screw();
      translate([10, -20, 40]) rotate([90, -90, 0]) angle_corner_with_screw();
      rotate([0, 0, 90]) vslot20x40(40, color_black);
      translate([10, 20, 40]) rotate([0, -90, 0]) angle_corner_with_screw();
      translate([10, 20, 20]) rotate([0, -90, 0]) angle_corner_with_screw();
      translate([0, 0, 43.20]) rotate([180, 0, 90]) acme_lead_screw_nut_block();
    }
  }
  translate([-w/2-10, 0, -10]) lead_screw_fixing_block();
  translate([w/2+10, 0, -10]) rotate([0, 0, 180]) lead_screw_fixing_block();

  // carriage
  module carriage() {
    rotate([0, 90, 0]) 20mm_v_plate();
    for (x=[20,-20], y=[20,-20]) translate([3.4, x, y]) rotate([0, 90, 0]) vwheel_with_screw(eccentric=(x>0)) xtreme_solid_vwheel();
    for (x=[10,-10]) translate([3.4, x, 0]) rotate([180, 90, 0]) screw_with_tnut();
  }
  cy = ceil( (h/2-60) / 250 );
  cd = (h/2-60)/cy;
  for (x=[-1,1], y=[cd*cy:-cd:cd*-cy]) if (y!=0) translate([(w/2+1.7)*x, y, 0]) rotate([0, 0, x>0?180:0]) carriage();
}

module z_mouvement_axe_fixation(h) {
  translate([20, 0, 0]) union() {
    /*translate([-10, -h/2, 10]) rotate([0, 0, -90]) angle_corner_with_screw();
    translate([-10, -h/2+20, -10]) rotate([0, 180, -90]) angle_corner_with_screw();*/
    translate([0, -h/2-3, 0]) rotate([-90, 0, 0]) m5_screw(15);
    translate([0, -h/2-1.5, 0]) rotate([90, 0, 0]) end_cap();
    translate([0, h/2, 0]) rotate([90, 0, 0]) vslot20x20(h);
    translate([0, h/2+1.5, 0]) rotate([-90, 0, 0]) end_cap();
    translate([0, h/2+3, 0]) rotate([90, 0, 0]) m5_screw(15);
    /*translate([-10, h/2-20, 10]) rotate([0, 0, -90]) angle_corner_with_screw();
    translate([-10, h/2, -10]) rotate([0, 180, -90]) angle_corner_with_screw();*/
  }
}

module z_mouvement_axe_vertical_fixation(length) {
  vslot20x20(length);
  for (z=[130,(length-40)]) {
    translate([-10, 10, z]) rotate([0, 0, 90]) angle_corner_with_screw();
    translate([-10, -10, z-20]) rotate([0, 180, 90]) angle_corner_with_screw();
  }
  for (0, z=[0,1]) {
    translate([0, 0, (length)*z]) rotate([z>0?0:180, 0, 180]) union() {
      translate([-10, -10, 0]) 2_joining_plate_with_screw();
      translate([10, 10, 0]) rotate([0, -90, 0]) angle_corner_with_screw();
      translate([10, -10, 0]) rotate([90, -90, 0]) angle_corner_with_screw();
    }
  }
}

module z_mouvement_axe(h, length) {
  translate([0, 0, -30]) rotate([180, 0, 45]) motor(Nema23, NemaMedium);
  translate([0, 0, -20]) flexible_coupling_5x8();
  translate([32.5, -40, 10]) rotate([0, 0, 90]) threaded_rod_plate_nema23();
  translate([0, 0, 12]) bearing(688);
  translate([0, 0, 18]) lock_collar();

  for (a=[0,90,180]) {
    translate([0, 0, 13]) rotate([-a, -90, 0]) union() {
      translate([-3.2, -33, 0]) rotate([-90, 0, 90]) spacer(40);
      translate([1.5, -33, 0])rotate([0, -90, 0]) m5_screw(55);
    }
  }

  translate([3.4, 0, 0]) z_mouvement_axe_fixation(h-50*2);
  acme_lead_screw(length+140);
  translate([3.4, 0, (length+120)+10]) z_mouvement_axe_fixation(h-50*2);

  translate([0, 0, (length+120)]) bearing(688);
  translate([0, 0, (length+120)+6]) lock_collar();
  translate([32.5, 40, (length+120)]) rotate([0, 180, 90]) threaded_rod_plate_nema23();

  for (y=[30, 0, -30], z=[9, length+121]) translate([23, y, z]) rotate([0, z < 50 ? 0 : 180, 0]) screw_with_tnut();
}

module z_axe(width, height, length, position=0, margin=20) {
  w=width+margin*2;
  h=height+margin*2;

  cy = ceil( (h/2-60) / 250 );
  cd = (h/2-60)/cy;

  for (x=[-w/2-13.5, w/2+13.5], y=[cd*cy:-cd:cd*-cy]) if(y!=0) translate([x, y, -150]) rotate([0, 0, x>0?180:0]) z_mouvement_axe_vertical_fixation(length+150+150);
  for (x=[-w/2-10, w/2+10]) translate([x, 0, -30]) rotate([0, 0, x > 0 ? 0 : 180]) z_mouvement_axe(h, length);

  translate([0, 0, length - position]) {
    translate([0, 0, 20]) z_axe_plate(w, h);
    translate([0, 0, 40]) children();
  }
}
