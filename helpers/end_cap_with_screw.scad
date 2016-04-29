use <../libs/openbuilds/brackets/end_cap.scad>;
use <../libs/openbuilds/screws/screw.scad>;

module end_cap_with_screw(n) {
  end_cap();
  translate([0, 1.5, 0]) rotate([180, 0, 0]) m5_screw(15);
}
