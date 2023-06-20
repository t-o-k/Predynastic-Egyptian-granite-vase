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

#declare SphereRadius = 0.002;

#declare SpheresInside =
    union {
        #for(J, 0, NoOfVertexIndicesInside - 1)
            #declare I = VertexIndicesInside[J];
            sphere { TrVertices[I], SphereRadius }
        #end // for
    }

#declare SpheresOutside =
    union {
        #for(J, 0, NoOfVertexIndicesOutside - 1)
            #declare I = VertexIndicesOutside[J];
            sphere { TrVertices[I], SphereRadius }
        #end // for
    }

#declare MeshInside =
    mesh {
        #for (K, 0, NoOfFaceIndicesInside - 1)
            #declare J = FaceIndicesInside[K];
            #declare I0 = FaceVertexIndices[J][0];
            #declare I1 = FaceVertexIndices[J][1];
            #declare I2 = FaceVertexIndices[J][2];
            triangle { TrVertices[I0], TrVertices[I1], TrVertices[I2] }
        #end // for
    }

#declare MeshOutside =
    mesh {
        #for (K, 0, NoOfFaceIndicesOutside - 1)
            #declare J = FaceIndicesOutside[K];
            #declare I0 = FaceVertexIndices[J][0];
            #declare I1 = FaceVertexIndices[J][1];
            #declare I2 = FaceVertexIndices[J][2];
            triangle { TrVertices[I0], TrVertices[I1], TrVertices[I2] }
        #end // for
    }

union {
    object {
        SpheresInside
        pigment { color rgb <2.0, 2.0, 0.0> }
    }
    object {
        SpheresOutside
        pigment { color rgb <0.0, 2.0, 2.0> }
    }
    object {
        MeshInside
        pigment { color rgb <1.0, 0.5, 0.2> }
    }
    object {
        MeshOutside
        pigment { color rgb <0.2, 0.5, 1.0> }
    }
    translate -1.1*y
    rotate +140*x // Also try -40*x
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.0, 0.5, 1.0>/20 }

light_source {
    100*<-4, +1, -4>
    color rgb <1.0, 1.0, 1.0>
    shadowless
}

camera {
    location -14.0*z
    look_at -0.8*y
    angle 48
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
