function z=fitgalaxies(filelist)

filelist;

flist=fopen(filelist);

while ~feof(flist)
  filename=fgetl(flist);
  [token,remain]=strtok(filename,'.');
  name = token;
  type = remain(2:length(remain));
  if type == 'dat'
    galaxyparameters(filename);
  end
end
fclose(flist);
