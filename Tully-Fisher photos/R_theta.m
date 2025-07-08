function z = R_theta(filename,xcentre,ycentre)
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
  
  rmax=99999;
  if rmax< ycentre
    rmax=ycentre;
  end
  if (ymax-ycentre)<rmax
    rmax = xmax-xcentre;
  end
  if rmax< xcentre
    rmax=xcentre;
  end
    if (xmax-xcentre)<rmax
    rmax = xmax-xcentre;
  end
  rmax=round(rmax*0.9);
Ave_colour=mean(I);
for i=(xcentre-rmax):(xcentre+rmax)
	for j=(ycentre-rmax):(ycentre+rmax)
		r=sqrt((i-xcentre)^2+(j-ycentre)^2);
		r
		if r <= rmax
			j_buffer=round(r);
			theta=0.0;
			if r>0;
			          theta=asin((j-ycentre)/r);
			end
			i_buffer=round(theta*50)+1;
			col=255;
			i
			j
			
			if I(i,j,1) > Ave_colour
				col=0;
			end
			i_buffer
			j_buffer
			Image_buffer(i_buffer,j_buffer,1)=col;
		end
	end
end

figure(2);
image(Image_buffer);
colormap(gray);

z = true;
end