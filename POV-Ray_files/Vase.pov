// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
/*

https://github.com/t-o-k/Predynastic-Egyptian-granite-vase

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#version 3.7;

global_settings { assumed_gamma 1.0 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#include "Vertices.inc"
#include "Face_Vertex_Indices.inc"

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare Vase =
    mesh2 {
        vertex_vectors {
            NoOfVertices,
            #for (I, 0, NoOfVertices - 1)
                Vertices[I],
            #end // for
        }
        face_indices {
            NoOfFaces,
            #for (I, 0, NoOfFaces - 1)
                <
                    FaceVertexIndices[I][0],
                    FaceVertexIndices[I][1],
                    FaceVertexIndices[I][2]
                >,
            #end // for
        }
        translate -vOffset
        rotate -Angle*y
    }

object {
    Vase
    rotate 180*x
    rotate -10*y
    pigment { color rgb <1.00, 0.85, 0.70> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.4, 0.7, 1.0>/20 }

light_source {
    100*<-7, +12, -8>
    color rgb <1, 1, 1>
}

camera {
    location <0.0, 2.2, -13.2>
    look_at <0, -2.3, 0>
    angle 34
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
