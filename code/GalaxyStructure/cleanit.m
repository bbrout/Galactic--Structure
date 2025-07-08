function [pic3]=cleanit(pic2,pix)

  %start double loop going through all the pixels
pic3=pic2;
  imax=size(pic2)(1);
  jmax=size(pic2)(2);
  for icount=1:imax
      light=0;
      pixcount=0;
      for jcount=1:jmax
        if (pic3(icount,jcount)>0) %there is a light
%          "light is on"
%          [icount jcount]
          if (light==0)
            light = 1; %turn on the light
%            "light turned on" 
%            [icount jcount] 
            pixcount=1;
%            pause
          else
%            "light is on continuing"
%            [icount jcount]
%            "increase pixel counter"
%            pixcount
            pixcount=pixcount+1;
%            pause
          endif          
        else %was the light turned off?
          if (light == 1) %light was turned off
            light = 0; %turn off the light
%            "light turned off"
%            [icount jcount]
%            pause
            if (pixcount<pix); %not long enough string of lights
%              "string not long enough"
%              [icount jcount]
%              pause   
              beginpix=jcount-pixcount;
              endpix=jcount-1;
              for jdummy=beginpix:endpix %turn out lights
%                "erasing pixels"
%                "icount jdummy" 
%                [icount jdummy]
                 pic3(icount,jdummy)=0;
%                pause
                endfor
              pixcount=0; %reset counter
            endif
          endif
        endif    
      endfor
  endfor
  for jcount=1:jmax
      light=0;
      pixcount=0;
      for icount=1:imax
        if (pic3(icount,jcount)>0) %there is a light
%          "light is on"
%          [icount jcount]
          if (light==0)
            light = 1; %turn on the light
%            "light turned on" 
%            [icount jcount] 
            pixcount=1;
%            pause
          else
%            "light is on continuing"
%            [icount jcount]
%            "increase pixel counter"
%            pixcount
            pixcount=pixcount+1;
%            pause
          endif          
        else %was the light turned off?
          if (light == 1) %light was turned off
            light = 0; %turn off the light
%            "light turned off"
%            [icount jcount]
%            pause
            if (pixcount<pix); %not long enough string of lights
%              "string not long enough"
%              [icount jcount]
%              pause   
              beginpix=icount-pixcount;
              endpix=icount-1;
              for idummy=beginpix:endpix %turn out lights
%                "erasing pixels"
%                "icount jdummy" 
%                [icount jdummy]
                 pic3(idummy,jcount)=0;
%                pause
                endfor
              pixcount=0; %reset counter
            endif
          endif
        endif    
      endfor
  endfor
  return;

