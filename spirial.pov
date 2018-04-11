
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "textures.inc"


#declare Camera_0 = camera {angle 25
                            location  <0.0 , 1.0 ,-8>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}


light_source{< 1500,2500,-2500> color White}

		   
#declare Amplitude = 0.60 ;
#declare Minimal_Length   = 0.80 ;
#declare Middle_Length    = Amplitude + Minimal_Length ;


#declare Time_test = 5; // 0.25/0.75 shows maximum/minimal extention!!!

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

  sphere { <0,0,0>, 0.4
          translate<0,-Nr*H_per_Ref/N_per_Rev-0.2,0>
          texture{ pigment{ color rgb<1,0.65,0>}}
        }
}

object { Spiral  translate< 0.0,2.42,0>}
