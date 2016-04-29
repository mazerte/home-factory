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
  translate([0, 0, 140]) z_axe(w, h, length, position=z) waste_board(w, h); //heated_bed(w, h);
  translate([0, 0, 0]) x_axe(w, position=x);
  translate([0, 0, 0]) y_axe(h, position=y)   cyclops_hotends(1.75);
}
