include <../../libs/openbuilds/utils/colors.scad>;

use <../../libs/openbuilds/linear_rails/vslot.scad>;
use <../../helpers/angle_corner_with_screw.scad>;
use <../../helpers/cube_corner_with_screw.scad>;
use <../../helpers/screw_with_tnut.scad>;

module build_plate_base(w, h, renfort=true, max_size=500) {
  for (y=[1,-1]) translate([-(w/2)+20, (h/2-10)*y]) rotate([0, 90, 0]) vslot(w-20*2);
  for (x=[1,-1]) translate([(w/2-10)*x, -(h/2)+20]) rotate([0, 90, 90]) vslot(h-20*2);
  for (x=[1,-1], y=[1,-1])
    translate([(w/2-10)*x, (h/2-10)*y, 0]) rotate([0, 0, x > 0 ? (y > 0 ? 0 : -90) : (y > 0 ? 90 : 180)])
      translate([-10, -10, -10]) cube_corner_with_screw(2);

  nb_x = floor(w/(max_size+1))+1; // add some renfort when it's max than max_size
  nb_y = floor(h/(max_size+1))+1; // add some renfort when it's max than max_size
  dx = (w-20)/nb_x;
  dy = (h-20)/nb_y;

  // Renfort
  if (renfort) {
    if (nb_y > 1)
      for(y=[1:nb_y-1]) translate([-(w/2)+20, -(h/2-10)+y*dy]) rotate([0, 90, 0]) vslot(w-20*2);
    for(x=[0:nb_x], y=[0:nb_y-1]) {
      px=-(w/2)+10+x*dx;
      py=-(h/2-20)+y*dy;
      plength=((h-20)-nb_y*20)/nb_y;
      if (x > 0) {
        if (y < nb_y-1 || x < nb_x)
          translate([px-10, py+plength, 10]) rotate([0, -90, 90]) angle_corner_with_screw();
        if (y > 0 || x < nb_x)
          translate([px-10, py, 10]) rotate([0, -90, 0]) angle_corner_with_screw();
      }
      if (x > 0 && x < nb_x) {
        translate([px, py, 0]) rotate([0, 90, 90]) vslot20x20(plength);
      }
      if (x < nb_x) {
        if (y > 0 || x > 0)
          translate([px+10, py, -10]) rotate([0, 90, 0]) angle_corner_with_screw();
        if (y < nb_y-1 || x > 0)
          translate([px+10, py+plength, -10]) rotate([0, 90, -90]) angle_corner_with_screw();
      }
    }
  }

  for (x=[1:nb_x]) {
    translate([-(w/2)+dx*x-dx/2, h/2, -30])  rotate([90, 0, 0]) union() {
      translate([10, 30, 0]) rotate([180, 0, 90]) screw_with_tnut();
    }
    translate([-(w/2)+dx*x-dx/2, -h/2, -30]) rotate([90, 0, 0]) union() {
      translate([10, 30, 0]) rotate([0, 0, 90]) screw_with_tnut();
    }
  }
}
