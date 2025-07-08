function [colmat]=createcolmat(pic2)

  %start double loop going through all the pixels
  imax=size(pic2)(1);
  jmax=size(pic2)(2);
  for icount=1:imax
      for jcount=1:jmax
        colmat(icount,jcount)=icount;
      endfor
  endfor
  return;

