// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
/*

https://github.com/t-o-k/Predynastic-Egyptian-granite-vase

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

// Render options: +a0.1 +w1600 +h1200

#version 3.7;

global_settings { assumed_gamma 1.0 }

default {
    texture {
        pigment { color rgb <1, 1, 1> }
        finish {
            diffuse 0
            emission color rgb <1, 1, 1>
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#include "functions.inc"  // For f_r()

// Vertices = array[NoOfVertices] { }
#include "Vertices.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare SphereRadius = 0.001;

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches

#declare VaseRadii =
    union {
        #for (I, 0, NoOfVertices - 1)
            #declare pV = Vertices[I];
            #declare pV = pV - vOffset;
            #declare RadiusXZ = f_r(pV.x, 0, pV.z);
            sphere { <0, pV.y, RadiusXZ>, SphereRadius }
        #end // for
        rotate +180*x
    }

union {
    object {
        VaseRadii
        rotate -90*y
    }
    object {
        VaseRadii
        rotate +90*y
    }
    pigment { color rgb <1.0, 0.5, 0.0> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.0, 0.5, 1.0>/30 }

#declare AR = image_width/image_height;

camera {
    orthographic
    direction z
    right AR*x
    up y
    sky y
    location < 0.00, -2.36, -10.00>
    angle 35
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
