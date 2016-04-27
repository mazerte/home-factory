use <parts/body.scad>;
use <parts/x_axe.scad>;
use <parts/y_axe.scad>;
use <parts/z_axe.scad>;

use <parts/build_plate/heated_bed.scad>;
use <parts/tools/bowden_extruder.scad>;
use <parts/tools/cyclops_hotends.scad>;

module home_factory(w, h, length, x=0, y=0, z=0) {
  if (w < 250 || h < 250 || length < 250) {
    echo("The minimum size of the home factory is 250x250x250 !");
    w = max(w, 250); h = max(h, 250); length = max(length, 250);
  }

  margin=100;
  body(w+margin*2, h+margin*2, length+margin*2);
  translate([0, 0, 0]) z_axe(w, h, length, position=z) heated_bed(w, h);
  translate([0, 0, 0]) x_axe(w+margin*2, position=x);
  translate([0, 0, 0]) y_axe(h+margin*2, position=y)   cyclops_hotends(1.75);
}
