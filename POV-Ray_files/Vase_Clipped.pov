// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#version 3.7;

global_settings { assumed_gamma 1.0 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

#include "Vertices.inc"
#include "Face_Vertex_Indices"

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
                >
            #end // for
        }
        translate -vOffset
        rotate -Angle*y
    }

#declare R_i_o = 0.9614;

#declare LatheInner =
    lathe {
        linear_spline
        11,
        <R_i_o,  0.10>,
        <R_i_o, -0.06>,
        < 0.85, -0.28>,
        < 1.30, -1.30>,
        < 1.52, -2.45>,
        < 1.40, -3.30>,
        < 1.00, -4.05>,
        < 0.50, -4.80>,
        < 0.10, -4.80>,
        < 0.10,  0.10>,
        <R_i_o,  0.10>
    }

#declare LatheOuter =
    lathe {
        linear_spline
        11,
        <R_i_o,  0.10>,
        <R_i_o, -0.06>,
        < 0.85, -0.28>,
        < 1.30, -1.30>,
        < 1.52, -2.45>,
        < 1.40, -3.30>,
        < 1.00, -4.05>,
        < 0.50, -4.80>,
        < 2.00, -4.80>,
        < 2.00,  0.10>,
        <R_i_o,  0.10>
    }

#declare VaseInner =
    object {
        Vase
        rotate 180*x
        clipped_by { LatheInner }
    }

#declare VaseOuter =
    object {
        Vase
        rotate 180*x
        clipped_by { LatheOuter }
    }

#declare BoxNegZ =
    box {
        <+2.0, +0.1, -1.8>,
        <-2.0, -4.8,  0.0>
    }

#declare BoxPosZ =
    box {
        <+2.0, +0.1,  0.0>,
        <-2.0, -4.8, +1.8>
    }

#declare PigmentInner = pigment { color rgb <1.0, 0.8, 0.1> }
#declare PigmentOuter = pigment { color rgb <0.2, 0.4, 1.0> }

#declare VaseInnerNegZ =
    object {
        VaseInner
        clipped_by { BoxNegZ }
        pigment { PigmentInner }
    }

#declare VaseInnerPosZ = 
    object {
        VaseInner
        clipped_by { BoxPosZ }
        pigment { PigmentInner }
    }

#declare VaseOuterNegZ =
    object {
        VaseOuter
        clipped_by { BoxNegZ }
        pigment { PigmentOuter }
    }

#declare VaseOuterPosZ =
    object {
        VaseOuter
        clipped_by { BoxPosZ }
        pigment { PigmentOuter }
    }

#declare VaseNegZ =
    union {
        object { VaseInnerNegZ }
        object { VaseOuterNegZ }
    }

#declare VasePosZ =
    union {
        object { VaseInnerPosZ }
        object { VaseOuterPosZ }
    }

union {
    object {
        VaseNegZ
        rotate -90*y
        translate -2.3*z
    }
    object {
        VasePosZ
        rotate +90*y
        translate +2.3*z
    }
    rotate +90*y
    rotate -90*x
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9

background { color rgb <0.8, 0.4, 1.0>/20 }

light_source {
    100*<-2, 3, -4>
    color rgb <1, 1, 1>
    shadowless
}

camera {
    location 3*< 0.0, +5.0, -3.0>
    look_at < 0.0, +2.7,  0.0>
    angle 30
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9
