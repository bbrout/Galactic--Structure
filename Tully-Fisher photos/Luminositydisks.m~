function z = Luminositydisks(filename,xcentre,ycentre,rmax)
%FITSPIRAL Summary of this function goes here
%   Detailed explanation goes here

imageFile=filename

Igalaxy = imread(imageFile);

I=Igalaxy;
II=double(I);

name=imageFile;
gamma=2.2;

figure(1);
image(I);
colormap(gray);
Ipic=double(I);
[token,remain]=strtok(name,'.');
token
remain(1)
remain(2:length(remain))

[xmax ymax zmax]=size(I);
%  
%  rmax=xcentre;
%  if rmax< ycentre
%    rmax=ycentre;
%  end
%  if (xmax-xcentre)<rmax
%    rmax = xmax-xcentre;
%  end
%  if (ymax-ycentre)<rmax
%    rmax = ymax-ycentre;
%  end
%  rmax

n=50;
dr=rmax/n
luminosity =0;

for i=1:n
  luminosityring(i)=0;
  ring(i)=i*dr;
end

for i=1:n
  r=ring(i);
  dtheta = 2*pi/100;
  theta=-dtheta;
  for (j=1:101)
     theta=theta+dtheta;
     ix=round(r*cos(theta))+ycentre;
     iy=round(r*sin(theta))+xcentre;
     Ipic(ix,iy,1)=255;
     Ipic(ix,iy,2)=255;
     Ipic(ix,iy,3)=255;
  end
end

figure(2);
image(Ipic);
colormap(gray);

for x=ycentre-rmax:ycentre+rmax
  for y=xcentre-rmax:xcentre+rmax
    ix=round(x);
    iy=round(y);
    rtest=(sqrt((ix-xcentre)^2 + (iy-ycentre)^2));
    if rtest < rmax
      IDUMMY=rtest/dr;
      iring=fix(IDUMMY)+1;
      lum=(II(ix,iy,1)/255)^(1/gamma)*255;
      luminosityring(iring)=luminosityring(iring)+lum;
      luminosity=luminosity+lum;
    end
  end
end

%  for i = 1:n
%    r1=(i-1)*dr;
%    r2=i*dr;
%    a1=pi*r1^2;
%    a2=pi*r2^2;
%    area=a2-a1;
%    luminosityring(i)=luminosityring(i)/area;
%  end

luminosity
figure(3);
plot(ring,luminosityring);

z = true;
end