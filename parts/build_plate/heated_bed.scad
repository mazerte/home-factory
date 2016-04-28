include <../../libs/openbuilds/utils/colors.scad>;

use <./base.scad>;

module heated_bed(width, height, margin=20) {
  w = width+margin*2;
  h = height+margin*2;

  build_plate_base(w, h);
  translate([0, 0, 10+1.5]) color(color_aluminum) cube([w, h, 3], center=true);

  // CoroPad
  translate([0, 0, 10+1.5+2]) color([179/255, 102/255, 255/255]) cube([width, height, 0.2], center=true);
}
