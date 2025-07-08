function z=barspiralgraph(filename)

    fid=fopen(filename);
    [A count] = fscanf(fid,'%f %f %f %f %f %f',[6 inf]);
    fclose(fid);
    n=0;
    for(i=1:count/6)
      n=n+1;
      vmax(n)=A(1,i);
      vmaxsigma(n)=A(2,i);
      barlength(n)=A(3,i);
      barlengthsigma(n)=A(4,i);
      wlength(n)=A(5,i);
      wlengthsigma(n)=A(6,i);
    end
    if n > 0
	xtx=0.0;
	xy=0.0;
	for (i=1:n)
	  xtx=xtx+barlength(i)^2;
	  xy=xy+barlength(i)*wlength(i);
	end

	m=(xtx)^(-1)*xy

	dx=(180-20)/100;
	xx=20;
	for (i=1:100)
	  xx=xx+dx;
	  x(i)=xx;
	  vc=xx; % rotational velocity in kps
          vc=vc/3e5; % rotational velocity in ly / yr
          w0=vc/(2*pi); %radians per year
          bl=1/w0; %bar length in ly
	  y(i)=bl/3.26/1e3; % bar length in kpc
	end
	
	vmax_figure_out=figure(1);
	hg=errorbar(vmax,barlength,vmaxsigma,vmaxsigma,barlengthsigma,barlengthsigma,"#~>ks");
	h = findobj (hg, "type", "line"); 
	delete (h(2)); 
	
	hold on;

	plot(x,y,'k','LineWidth',2)
	
	hold on;
	
	plot(vmax,barlength,' sk','MarkerSize',10);
	xlabel("v_{max} k s^{-1}",'FontSize',12);
	ylabel("Length of Bar (Kpc)",'FontSize',12);
	title("Length of bar vs v_{max}",'FontSize',18);
        filename_output=strcat('vmaxvsbar','.eps');
	print(vmax_figure_out,filename_output,'-deps');

	hold off;
%  
%  	dx=15/100
%  	xx=0;
%  	for (i=1:100)
%  	  xx=xx+dx;
%  	  x(i)=xx;
%  	  y(i)=m*xx;
%  	end
%  	
%  	barcompare_figure_out=figure(2);
%  	hg=errorbar(barlength,wlength,barlengthsigma,barlengthsigma,wlengthsigma,wlengthsigma,"#~>ks");
%  	h = findobj (hg, "type", "line"); 
%  	delete (h(2)); 
%  	
%  	hold on;
%  
%  	plot(x,y,'k','LineWidth',2)
%  	
%  
%  	xlabel("Length of Bar (Kpc)",'FontSize',12);
%  	ylabel("Predicted Length of Bar (Kpc)",'FontSize',12);
%  	title("Predicted Length vs Length of bar",'FontSize',18);
%  	hold on;
%  	
%    	plot(barlength,wlength,' sk','MarkerSize',10);
%  
%          filename_output=strcat('barcompare','.eps');
%  	print(barcompare_figure_out,filename_output,'-deps');
%  	
%  %	hold off;
    end
end
    
