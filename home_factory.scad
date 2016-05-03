use <parts/body.scad>;
use <parts/x_axe.scad>;
use <parts/y_axe.scad>;
use <parts/z_axe.scad>;

use <parts/build_plate/heated_bed.scad>;
use <parts/build_plate/waste_board.scad>;

use <parts/tools/bowden_extruder.scad>;
use <parts/tools/cyclops_hotends.scad>;

module home_factory(w, h, length, x=0, y=0, z=0) {
  if (w < 250 || h < 250 || length < 250) {
    echo("The minimum size of the home factory is 250x250x250 !");
    w = max(w, 250); h = max(h, 250); length = max(length, 250);
  }
  if (w > 1000 || h > 1000 || length > 1000) {
    echo("The maximum size of the home factory is 1000x1000x1000 !");
    w = min(w, 1000); h = min(h, 1000); length = min(length, 1000);
  }

  body(w, h, length);
  translate([0, 0, 140]) z_axe(w, h, length, position=z) heated_bed(w, h); // waste_board(w, h); //
  translate([0, 0, length+140+150]) y_axe(w, h, position=y);
  translate([0, h/2-y, length+140+150]) x_axe(w, position=x) cyclops_hotends(1.75);
}
