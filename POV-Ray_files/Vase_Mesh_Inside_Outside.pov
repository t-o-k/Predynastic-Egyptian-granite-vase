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

// VertexIndicesInside = array[NoOfVertexIndicesInside]
#include "Vertex_Indices_Inside.inc"

// VertexIndicesOutside = array[NoOfVertexIndicesOutside]
#include "Vertex_Indices_Outside.inc"

// FaceVertexIndices = array[NoOfFaces][3]
#include "Face_Vertex_Indices.inc"

// FaceIndicesInside = array[NoOfFaceIndicesInside]
#include "Face_Indices_Inside.inc"

// FaceIndicesOutside = array[NoOfFaceIndicesOutside]
#include "Face_Indices_Outside.inc"

// EdgeVertexIndices = array[NoOfEdges][2]
#include "Edge_Vertex_Indices.inc"

// EgdeIndicesInside = array[NoOfEgdeIndicesInside]
#include "Edge_Indices_Inside.inc"

// EgdeIndicesOutside = array[NoOfEgdeIndicesOutside]
#include "Edge_Indices_Outside.inc"

// EgdeIndicesBetween = array[NoOfEgdeIndicesBetween]
#include "Edge_Indices_Between.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare MeshInside =
    mesh {
        #for (K, 0, NoOfFaceIndicesInside - 1)
            #declare J = FaceIndicesInside[K];
            #declare I0 = FaceVertexIndices[J][0];
            #declare I1 = FaceVertexIndices[J][1];
            #declare I2 = FaceVertexIndices[J][2];
            triangle { Vertices[I0], Vertices[I1], Vertices[I2] }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare MeshOutside =
    mesh {
        #for (K, 0, NoOfFaceIndicesOutside - 1)
            #declare J = FaceIndicesOutside[K];
            #declare I0 = FaceVertexIndices[J][0];
            #declare I1 = FaceVertexIndices[J][1];
            #declare I2 = FaceVertexIndices[J][2];
            triangle { Vertices[I0], Vertices[I1], Vertices[I2] }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare SphereRadius = 0.002;

#declare SpheresInside =
    union {
        #for (J, 0, NoOfVertexIndicesInside - 1)
            #declare I = VertexIndicesInside[J];
            sphere { Vertices[I], SphereRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare SpheresOutside =
    union {
        #for (J, 0, NoOfVertexIndicesOutside - 1)
            #declare I = VertexIndicesOutside[J];
            sphere { Vertices[I], SphereRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare CylinderRadius = 0.001;

#declare CylindersInside =
    union {
        #for (K, 0, NoOfEdgeIndicesInside - 1)
            #declare J = EdgeIndicesInside[K];
            #declare I0 = EdgeVertexIndices[J][0];
            #declare I1 = EdgeVertexIndices[J][1];
            cylinder { Vertices[I0], Vertices[I1], CylinderRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare CylindersOutside =
    union {
        #for (K, 0, NoOfEdgeIndicesOutside - 1)
            #declare J = EdgeIndicesOutside[K];
            #declare I0 = EdgeVertexIndices[J][0];
            #declare I1 = EdgeVertexIndices[J][1];
            cylinder { Vertices[I0], Vertices[I1], CylinderRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare CylindersBetween =
    union {
        #for (K, 0, NoOfEdgeIndicesBetween - 1)
            #declare J = EdgeIndicesBetween[K];
            #declare I0 = EdgeVertexIndices[J][0];
            #declare I1 = EdgeVertexIndices[J][1];
            cylinder { Vertices[I0], Vertices[I1], CylinderRadius }
        #end // for
        translate -vOffset
        rotate -Angle*y
    }

#declare TorusMajorRadius = 0.9614; // R_i_o
#declare TorusMinorRadius = 0.001;

union {
    object {
        MeshInside
        pigment { color rgb <1.0, 0.5, 0.2> }
    }
    object {
        MeshOutside
        pigment { color rgb <0.2, 0.5, 1.0> }
    }
    object {
        SpheresInside
        pigment { color rgb <1.0, 1.0, 0.0>*2.0 }
    }
    object {
        SpheresOutside
        pigment { color rgb <0.0, 1.0, 1.0>*2.0 }
    }
    object {
        CylindersInside
        pigment { color rgb <1.0, 0.8, 0.5>*1.2 }
    }
    object {
        CylindersOutside
        pigment { color rgb <0.5, 0.8, 1.0>*1.2 }
    }
    object {
        CylindersBetween
        pigment { color rgb <0.0, 0.0, 0.0> }
    }
    torus {
        TorusMajorRadius, TorusMinorRadius
        translate -0.0003*y
        pigment { color rgb <1.0, 1.0, 1.0>*2.0 }
    }
    rotate 180*x
    rotate -10*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.4, 0.7, 1.0>/20 }

light_source {
    100*<-7, +12, -8>
    color rgb <1, 1, 1>
}

camera {
    translate -5*z
    rotate +90*x
    angle 38
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
