include <MCAD/materials.scad>;

use <./base.scad>;

module waste_board(width, height, margin=20) {
  w = width+margin*2;
  h = height+margin*2;

  build_plate_base(w, h);

  pinch=25;
  color(Pine) difference() {
    translate([0, 0, 10]) cube([w, h, 10], center=true);
    translate([-w/2+margin, -h/2+margin, 10]) union() {
      for (x=[0:pinch:width], y=[0:pinch:height]) translate([x, y, -0.5]) cylinder(r=4, h=10+1);
    }
  }
}
