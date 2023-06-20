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

// FaceVertexIndices = array[NoOfFaces][3]
#include "Face_Vertex_Indices.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare TrVertices = array[NoOfVertices]; // Transformed vertices
#for (I, 0, NoOfVertices - 1)
    #declare pV = vrotate(Vertices[I] - vOffset, -Angle*y);
    #declare Radius = vlength(<pV.x, 0, pV.z>);
    #declare Cos = pV.x/Radius;
    #declare Sin = pV.z/Radius;
    #declare Height = 5.2 - pV.y; // 5.2 inches is a bit more than the height of the vase
    // #declare Height = 0.5 + pV.y; // Also try this
    #declare TrVertices[I] = Height*(Cos*x + Sin*z) + Radius*y;
#end // for

#declare SphereRadius = 0.0035;

#declare Spheres =
    union {
        #for(I, 0, NoOfVertices - 1)
            sphere { TrVertices[I], SphereRadius }
        #end // for
    }

#declare Mesh2 =
    mesh2 {
        vertex_vectors {
            NoOfVertices,
            #for (I, 0, NoOfVertices - 1)
                TrVertices[I],
            #end // for
        }
        face_indices {
            NoOfFaces,
            #for (K, 0, NoOfFaces - 1)
                <
                    FaceVertexIndices[K][0],
                    FaceVertexIndices[K][1],
                    FaceVertexIndices[K][2]
                >,
            #end // for
        }
    }

union {
    object {
        Spheres
        pigment { color rgb <2.0, 0.0, 0.0> } 
    }
    object {
        Mesh2
        pigment { color rgb <1.0, 1.0, 1.0> }
    }
    translate -1.1*y
    rotate -20*y
    rotate -90*x // Also try +90*x
}
 
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.0, 0.5, 1.0>/20 }

light_source {
    100*<-6, +1, -4>
    color rgb <1.0, 1.0, 1.0>
    shadowless
}

camera {
    orthographic
    location -16*z
    angle 50
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
