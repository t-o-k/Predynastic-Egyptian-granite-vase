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

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

// Vertices = array[NoOfVertices]
#include "Vertices.inc"

// EdgeVertexIndices = array[NoOfEdges][2]
#include "Edge_Vertex_Indices.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare SphereRadius = 0.0004;
#declare CylinderRadius = 0.0004;

#declare Vase =
    union {
        union {
            #for (I, 0, NoOfVertices - 1)
                sphere { Vertices[I], SphereRadius }
            #end // for
        }
        union {
            #for (I, 0, NoOfEdges - 1)
                #declare I0 = EdgeVertexIndices[I][0];
                #declare I1 = EdgeVertexIndices[I][1];
                cylinder { Vertices[I0], Vertices[I1], CylinderRadius }
            #end // for
        }
        translate -vOffset
        rotate -Angle*y
    }

object {
    Vase
    pigment { color rgb <1.0, 1.0, 1.0> }
    rotate 180*x
    rotate -60*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.4, 0.7, 1.0>/20 }

light_source {
    100*<-7, +12, -8>
    color rgb <1, 1, 1>
}

camera {
    location < 0.0, +1.0, -4.5>
    look_at < 0.0, -0.4,  0.0>
    angle 34
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
