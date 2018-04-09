



// I've found that the easiest way to view changes in real time
// is to set up the POVRAY with +KFF360,
// Then, change something on this .pov file and save while its still
// rendering. The povray renderer doesnt care if the file is modified in the middle of rendering,
// itll just use the new file. If you do this alot and make a movie of all the scenes, it looks weired.



#version 3.5;
#include "colors.inc"
#include "waves.inc"
#default { finish { ambient 0.07 }}
#declare Scale_Z = 0.02;

global_settings {
  assumed_gamma 1.0
  max_trace_level 15
}

///////////////////////////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////////////////////////

#declare Siz=2+clock*2;									//How far away are you from the pool? Probably leave at 4

///////////////////////////////////////////////////////////////////////////////////////////////////

#declare Height=0.1;									//How rippled are the waves? i.e. how high? Probably leave at 0.1-0.3

///////////////////////////////////////////////////////////////////////////////////////////////////

#declare MAX_WAVES = 10;								//Want less waves? Want more waves? Adjust accordingly, but no high numbers like 600

///////////////////////////////////////////////////////////////////////////////////////////////////

#declare fn_Water=
function {
  Waves(pi/2, 5.9, clock*50, 700) * 0.024 + 6.5		//Each value here changes the intensity of the wave. Change the clock for more waves
}

///////////////////////////////////////////////////////////////////////////////////////////////////

light_source { <1, 1, 1> 1 }

///////////////////////////////////////////////////////////////////////////////////////////////////

camera {
  location  <1,  0, 0.1>								// standard xyz, z should stay at 0.1
  direction y
  sky       z
  up        z
  right     (4/3)*x
  look_at   <0.0, 0.0, 0.0>								// Where to point camera, 0-0-0 is center of water, should be fine		
  angle 60												// Similar to fov in a video game, 60 should be fine
  rotate<0,0,clock*1>
}

///////////////////////////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////////////////////////

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