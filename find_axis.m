function [majoraxisbegin majoraxisend minoraxisbegin minoraxisend majoraxis aa bb] = find_axis(pic2,picture,rowmid,colmid,rowmax,colmax,m,b)

figure(4);
imshow(picture);

 X=[0 colmax];
 Y=[rowmid rowmid];
 line(X,Y,"linestyle","-","color","r");
 X=[colmid colmid];
 Y=[0 rowmax];
 line(X,Y,"linestyle","-","color","r");
 
  pix=255;
  colnum=colmid;
  while (pix==255)
    colnum=colnum+1;
    rownum=round(m*colnum+b);
    pix=pic2(rownum,colnum);
 %   hold on;
 %   plot(colnum,rownum,'r+', 'MarkerSize', 50);
  endwhile
  
%  colnum
%  rownum
  
  majoraxiscolend=colnum;
  majoraxisrowend=rownum;
  majoraxisend=[rownum colnum];
  majoraxiscollength=2*(colnum-colmid);
  majoraxisrowlength=2*(rowmid-rownum);
  aa=sqrt(majoraxiscollength*majoraxiscollength+majoraxisrowlength*majoraxisrowlength);
  majoraxiscolbegin=colnum-majoraxiscollength;
  majoraxisrowbegin=rownum+majoraxisrowlength; 
  
  majoraxisbegin=[majoraxisrowbegin majoraxiscolbegin];
  

  
  m2=-1./m;
  b2=(rowmid-m2*colmid);
  colnum=colmid;
  pix=255;
  while (pix==255);
    colnum=colnum+1;
    rownum=round(m2*colnum+b2);
    pix=pic2(rownum,colnum);
%    hold on;
%    plot(colnum,rownum,'r+', 'MarkerSize', 50);
  endwhile

%  colnum
%  rownum
  minoraxiscolend=colnum;
  minoraxisrowend=rownum;
  
  minoraxisend=[rownum colnum];
  minoraxiscollength=2*(colnum-colmid);
  minoraxisrowlength=2*(rowmid-rownum);
  bb=sqrt(minoraxiscollength*minoraxiscollength+minoraxisrowlength*minoraxisrowlength);
  minoraxiscolbegin=colnum-minoraxiscollength;
  minoraxisrowbegin=rownum+minoraxisrowlength; 
  
  minoraxisbegin=[minoraxisrowbegin minoraxiscolbegin];


  ii=0;
  for (colnum=majoraxiscolbegin:majoraxiscolend)  
    rownum=round(m*colnum+b);
    ii=ii+1;
    majoraxis(ii)=picture(rownum,colnum);
  endfor

  X=[majoraxiscolbegin majoraxiscolend];
 Y=[majoraxisrowbegin majoraxisrowend];
 line(X,Y,"linestyle","-","color","r");


line(X,Y,"linewidth",5.0,"linestyle","-","color","g");

X=[minoraxiscolbegin minoraxiscolend];
Y=[minoraxisrowbegin minoraxisrowend];
line(X,Y,"linewidth",5.0,"linestyle","-","color","g");

  
endfunction
