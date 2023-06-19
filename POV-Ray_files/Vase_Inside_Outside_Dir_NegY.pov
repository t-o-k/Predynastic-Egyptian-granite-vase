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

// Vertices = array[NoOfVertices]
#include "Vertices.inc"

// VertexIndicesInside = array[NoOfVertexIndicesInside]
#include "Vertex_Indices_Inside.inc"

// VertexIndicesOutside = array[NoOfVertexIndicesOutside]
#include "Vertex_Indices_Outside.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare SphereRadius = 0.001;

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare VaseInside =
    union {
        #for (J, 0, NoOfVertexIndicesInside - 1)
            #declare I = VertexIndicesInside[J];
            sphere { Vertices[I], SphereRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }
#declare VaseOutside =
    union {
        #for (J, 0, NoOfVertexIndicesOutside - 1)
            #declare I = VertexIndicesOutside[J];
            sphere { Vertices[I], SphereRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

union {
    object {
        VaseInside
        pigment { color rgb <1.0, 0.5, 0.0> }
    }
    object {
        VaseOutside
        pigment { color rgb <0.0, 0.5, 1.0> }
    }
    rotate 180*x
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.5, 1.0, 0.0>/100 }

#declare AR = image_width/image_height;
#declare S = 5.5;

camera {
    orthographic
    direction -y
    right +AR*x
    up +z
    sky +y
    scale S*<1, 1, 1>
    translate < 0.00, +10.00,  0.00>
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
