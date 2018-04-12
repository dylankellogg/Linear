// I've found that the easiest way to view changes in real time
// is to set up the POVRAY with +KFF360,
// Then, change something on this .pov file and save while its still
// rendering. The povray renderer doesnt care if the file is modified in the middle of rendering,
// itll just use the new file. If you do this alot and make a movie of all the scenes, it looks weired.

///////////////////////////////////////////////////////////////////////////////////////////////////

#version 3.5;
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
#include "basic-shapes.inc"
#include "colors.inc"
#include "waves.inc"
#default { finish { ambient 0.07 }}
#declare Scale_Z = 0.02;

global_settings {
  assumed_gamma 1.0
  max_trace_level 15
}

#declare M_Watx =
material {
  texture {
    pigment {
      color rgbt <0.350, 0.500, 1.950, 0.8>
    }
    finish {
      diffuse 0.3
      ambient 0.0
      reflection {
        0.03, 1.0
        fresnel on
      }
      conserve_energy
      specular 0.4
      roughness 0.003
    }
  }
  interior {
    ior 1.33
    fade_distance 0.3
    fade_power 1001
    fade_color <0.350, 0.500, 0.950>
  }
}

#declare Siz=4;									//How far away are you from the pool? Probably leave at 4

#declare Height=0.1;									//How rippled are the waves? i.e. how high? Probably leave at 0.1-0.3

#declare MAX_WAVES = 10;								//Want less waves? Want more waves? Adjust accordingly, but no high numbers like 600

#declare fn_Water=
function {
  Waves(pi/2, 5.9, clock*50, 700) * 0.024 + 6.5			//Each value here changes the intensity of the wave. Change the clock for more waves
}

light_source { <5, 5, 5> 5 }							// <x,y,z> above 1, last value is intensity

camera {
  location  <1,  0, -.5>								// standard xyz, z should stay at 0.1
  direction y
  sky       z
  up        z
  right     (4/3)*x
  look_at   <0.0, 0.0, -0.6>								// Where to point camera, 0-0-0 is center of water, should be fine		
  angle 60												// Similar to fov in a video game, 60 should be fine
  rotate<0,0,clock*1>
}

height_field {
  function 300, 300 { fn_Water(x, y, 0) }
  smooth
  rotate -90*x
  translate <-0.5,-0.5,0.5>
  scale <Siz,Siz,Height>
  material {
    M_Watx
  }
  hollow off
}

difference {
  box { < -(Siz/2+0.2), -(Siz/2+0.2),-1>, <(Siz/2+0.2), (Siz/2+0.2),0.05> }
  box { < -(Siz/2-0.1), -(Siz/2-0.1),-0.99>, <(Siz/2-0.1), (Siz/2-0.1),0.2> }
  texture {
    pigment {
      color rgb <0, 0, 0>
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#declare Amplitude = 0.06 ;
#declare Minimal_Length   = 0.08 ;
#declare Middle_Length    = Amplitude + Minimal_Length ;


#declare Time_test = 6; // 0.25/0.75 shows maximum/minimal extention!!!

#declare Sp_Length = Middle_Length+Amplitude*sin((clock+Time_test)*2*pi);



#declare Spiral  = 
union{
 #local N_per_Rev = 1;   // Number of Elements per revolutions
 #local N_of_Rev  = 80.00;  // Total number of revolutions
 #local H_per_Ref = Sp_Length / N_of_Rev;// Height per revolution
 #local Nr = 0;                          // start loop
 #while (Nr< (N_per_Rev*N_of_Rev))
 
 #local Nr = Nr + 1;
 #end
/////

sphere { <0,0,.5>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0.5>, 0.035
  translate<0,-2.35+.5*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0.5>, 0.035
  translate<0,-2.35+.7*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0.5>, 0.035
  translate<0,-2.35+(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0.5>, 0.035
  translate<0,-2.45-.5*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0.5>, 0.035
  translate<0,-2.45-.7*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0.5>, 0.035
  translate<0,-2.45-(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

///////////////////////

sphere { <0,0,.4>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0.4>, 0.035
  translate<0,-2.37+.125*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0.4>, 0.035
  translate<0,-2.37+.1525*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0.4>, 0.035
  translate<0,-2.37+.25*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0.4>, 0.035
  translate<0,-2.43-.125*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0.4>, 0.035
  translate<0,-2.43-.1525*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0.4>, 0.035
  translate<0,-2.43-.25*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

//////////

sphere { <0,0,.3>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0.3>, 0.035
  translate<0,-2.37+.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0.3>, 0.035
  translate<0,-2.37+.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0.3>, 0.035
  translate<0,-2.37+.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0.3>, 0.035
  translate<0,-2.43-.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0.3>, 0.035
  translate<0,-2.43-.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0.3>, 0.035
  translate<0,-2.43-.075*(Nr*H_per_Ref/N_per_Rev-0.2),-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

//////////

sphere { <0,0,.2>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0.2>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0.2>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0.2>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0.2>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0.2>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0.2>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

//////////

sphere { <0,0,.1>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0.1>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0.1>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0.1>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0.1>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0.1>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0.1>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

//////////

sphere { <0,0,.0>, 0.035
  translate<0,-2.4,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.125,0>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,0.25,0>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,.375,0>, 0.035
  translate<0,-2.37,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.125,0>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.25,0>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}
sphere { <0,-0.375,0>, 0.035
  translate<0,-2.43,-0.85>
  texture{ pigment{ color rgb<0,0,1>}}
}

//////////
}

object { Spiral  translate< 0.0,2.42,0>}
	  