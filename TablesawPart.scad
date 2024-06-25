#include <BOSL2/std.scad>

thickness = 1; // 3 for real thing, 1 for 3D printed model
width = 509; // 509 for real thing, 170 for 3D printed model
height = 109;
corner_radius = 9;

riving_knife_thickness = 2.8;
riving_knife_clearance = 0.1;
riving_knife_from_top = 27.2;
riving_knife_from_left = 30; // with margin
riving_knife_width = 130;    // with margin

slit_from_left = riving_knife_from_left;

finger_hole_diameter = 20;

module __Configurator_End__()
{
}

slit_width = riving_knife_width;
slit_height = riving_knife_thickness + 2 * riving_knife_clearance;
slit_centre = height - riving_knife_from_top - riving_knife_clearance - riving_knife_thickness / 2;

module shape()
{
    rect([ width, height ], rounding = corner_radius, anchor = LEFT + FRONT);
}

module slit()
{
    translate([ slit_from_left, slit_centre - slit_height / 2, 0 ])
        rect([ slit_width, slit_height ], anchor = LEFT + FRONT);
}

module finger_hole()
{
    translate([ width - finger_hole_diameter, height / 2, 0 ]) circle(d = finger_hole_diameter);
}

module guide()
{
    difference()
    {
        shape();
        slit();
        finger_hole();
    }
}

module stl()
{
    linear_extrude(height = thickness) guide();
}

guide();