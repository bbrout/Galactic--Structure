function [pic2 colmat]=bwcontrast(picture)
  % function to get total contrast from picture of galaxy
  %first save the image
  pic2 = picture;
  %find average intensity
  aveintense = mean(mean(pic2));

  %start double loop going through all the pixels
  %and reduce picture to straight black and white

  imax=size(picture)(1);
  jmax=size(picture)(2);

  for icount=1:imax
      for jcount=1:jmax
          % faster than double if statements
          pic2(icount,jcount)=0;
          if picture(icount,jcount)>aveintense
            pic2(icount,jcount)=255;
          endif
          colmat(icount,jcount)=icount;
      endfor
  endfor
  return;

