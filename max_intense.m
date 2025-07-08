function   [pic2]=max_intense(picture) 

  %find average intensity
  aveintense=max(max(picture))/4;

  %start double loop going through all the pixels
  %and reduce picture to straight black and white

  rowmax=size(picture)(1);
  colmax=size(picture)(2);

  for icount=1:rowmax
      for jcount=1:colmax
          % faster than double if statements
          pic2(icount,jcount)=0;
          if picture(icount,jcount)>aveintense
            pic2(icount,jcount)=255;
          endif
          colmat(icount,jcount)=icount;
      endfor
  endfor
return