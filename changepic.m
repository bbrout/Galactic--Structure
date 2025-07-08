function [pic2]=changepic(pic)

  %start double loop going through all the pixels
  imax=size(pic)(1);
  jmax=size(pic)(2);
  for icount=1:imax
      for jcount=1:jmax
        pic2(icount,jcount)=int32(pic(icount,jcount));
      endfor
  endfor
  return;

