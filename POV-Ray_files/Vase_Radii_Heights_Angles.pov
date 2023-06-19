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

// VertexIndicesOutside = array[NoOfVertexIndicesOutside]
#include "Vertex_Indices_Outside.inc"

// FaceVertexIndices = array[NoOfFaces][3]
#include "Face_Vertex_Indices.inc"

// FaceIndicesOutside = array[NoOfFaceIndicesOutside]
#include "Face_Indices_Outside.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#declare Tau = 2*pi;

#declare vOffset = <+0.7,  0.0, -39.0>/1000; // Inches
#declare Angle = -12.68; // Degrees

#declare Angles = array[NoOfVertices];
#declare AnglesLT = array[NoOfVertices];
#declare AnglesGT = array[NoOfVertices];
#declare Radii = array[NoOfVertices];
#declare Heights = array[NoOfVertices];

#declare Cneg = -pi/2;
#declare Cpos = +pi/2;

#for (I, 0, NoOfVertices - 1)
    #declare Vertices[I] = vrotate(Vertices[I] - vOffset, -(Angle + 90)*y);
    #declare Angles[I] = atan2(Vertices[I].z, Vertices[I].x); // -pi < Angles[I] <= +pi
    #declare AnglesLT[I] = (Angles[I] < Cneg);
    #declare AnglesGT[I] = (Cpos < Angles[I]);
    #declare Radii[I] = vlength(<Vertices[I].x, 0, Vertices[I].z>);
    #declare Heights[I] = Vertices[I].y;
#end // for

#declare SphereRadius = 0.002;

#declare Spheres =
    union {
        #for(J, 0, NoOfVertexIndicesOutside - 1)
            #declare I = VertexIndicesOutside[J];
            sphere { <Radii[I], Heights[I], Angles[I]>, SphereRadius }
        #end // for
    }

#declare Triangles =
    union {
        #for (J, 0, NoOfFaceIndicesOutside - 1)
            #declare I = FaceIndicesOutside[J];
            #declare I0 = FaceVertexIndices[I][0];
            #declare I1 = FaceVertexIndices[I][1];
            #declare I2 = FaceVertexIndices[I][2];
            #declare Angle0 = Angles[I0];
            #declare Angle1 = Angles[I1];
            #declare Angle2 = Angles[I2];
            #if (AnglesGT[I1] & AnglesLT[I2])
                #if (AnglesLT[I0])
                    #declare Angle1 = Angle1 - Tau;
                #end // if
                #if (AnglesGT[I0])
                    #declare Angle2 = Angle2 + Tau;
                #end // if
            #end // if
            #if (AnglesGT[I2] & AnglesLT[I0])
                #if (AnglesLT[I1])
                    #declare Angle2 = Angle2 - Tau;
                #end // if
                #if (AnglesGT[I1])
                    #declare Angle0 = Angle0 + Tau;
                #end // if
            #end // if
            #if (AnglesGT[I0] & AnglesLT[I1])
                #if (AnglesLT[I2])
                    #declare Angle0 = Angle0 - Tau;
                #end // if
                #if (AnglesGT[I2])
                    #declare Angle1 = Angle1 + Tau;
                #end // if
            #end // if
            triangle {
                <Radii[I0], Heights[I0], Angle0>,
                <Radii[I1], Heights[I1], Angle1>,
                <Radii[I2], Heights[I2], Angle2>
            }
        #end // for
    }

union {
    object {
        Triangles
        pigment { color rgb <1.0, 1.0, 1.0> }
    }
    object {
        Spheres
        pigment { color rgb <2.0, 0.0, 0.0> } 
    }
    translate <-1.4, -2.4,  0.0>
    rotate +180*z
    rotate -90*y // Also try +90*y and 0*y
}
    
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.0, 0.5, 1.0>/20 }

light_source {
    100*<-4, +1, -4>
    color rgb <1.0, 1.0, 1.0>
    shadowless
}

camera {
    orthographic
    location -9*z
    angle 40
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
