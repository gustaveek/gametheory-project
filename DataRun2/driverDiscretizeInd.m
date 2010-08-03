% driverDiscretizeInd.m. Driver script for the discritisation function

for i = 1:20
  genome = rand(1, 6);
  disGeno =  discretizeInd (genome);
  disp (genome);
  disp (disGeno);
  disp (' ');
end


x = linspace(0,1,1000);
y = x;
for i = 1:length(x)
  y(i) = discretizeInd (x(i));
end
plot (x, y)