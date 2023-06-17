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

// Vertices = array[NoOfVertices] { }
#include "Vertices.inc"

// FaceVertexIndices = array[NoOfFaces] { }
#include "Face_Vertex_Indices.inc"

// VertexNormals = array[NoOfVertexNormals] { }
#include "Vertex_Normals.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare VertexSphereRadius = 0.0012;
#declare NormalCylinderRadius = 0.0008;
#declare EdgeCylinderRadius = 0.0004;

#declare VertexSpheres =
    union {
        #for (I, 0, NoOfVertices - 1)
            sphere { Vertices[I], VertexSphereRadius }
        #end // for
    }

#declare FaceMesh =
    mesh2 {
        vertex_vectors {
            NoOfVertices,
            #for (I, 0, NoOfVertices - 1)
                Vertices[I],
            #end // for
        }
        normal_vectors {
            NoOfVertices,
            #for (I, 0, NoOfVertices - 1)
                VertexNormals[I],
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
        inside_vector x
    }

#declare NormalCylinders =
    union {
        #for (I, 0, NoOfVertices - 1)
            cylinder {
                <0, 0, 0>, 0.01*VertexNormals[I], NormalCylinderRadius
                translate Vertices[I]
            }
        #end // for
    }

#declare EdgeCylinders =
    union {
        #for (I, 0, NoOfFaces - 1)
            #declare I0 = FaceVertexIndices[I][0];
            #declare I1 = FaceVertexIndices[I][1];
            #declare I2 = FaceVertexIndices[I][2];
            cylinder { Vertices[I0], Vertices[I1], EdgeCylinderRadius }
            cylinder { Vertices[I1], Vertices[I2], EdgeCylinderRadius }
            cylinder { Vertices[I2], Vertices[I0], EdgeCylinderRadius }
        #end // for
    }

#declare Vase =
    union {
        object {
            VertexSpheres
            pigment { color rgb <0, 0, 2> }
        }
        object {
            FaceMesh
            pigment { color rgb <1, 1, 1> }
        }
        object {
            NormalCylinders
            pigment { color rgb <2, 0, 0> }
        }
        object {
            EdgeCylinders
            pigment { color rgb <0, 0, 0> }
        }
        translate -vOffset
        rotate -Angle*y
    }

object {
    Vase
    rotate +180*x
    rotate -115*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

light_source {
    100*<-2, 3, -4>
    color rgb <1, 1, 1>
    shadowless
}

camera {
    location < 0,  0, -2>*7
    look_at <+14, -33,  0>/20
    angle 6
}

background { color rgb 0.3*<1, 1, 1> }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
