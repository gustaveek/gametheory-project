% driverHarshGame.m Test script for the harsh function

param = struct ('nHarshes', 200);
isOk = 1;

%% Test for floating point numbers. 
nTests = 100;
inds = cell(nTests+1, 1);
for i = 1:nTests+1
  inds{i} = rand(1, randi(64, 1));
end

harshes  = zeros(1, nTests);
for i = 1:nTests
  harshes(i) = harshGame(inds{i}, inds{i+1}, param);
end
harshesOld = harshes;

for j = 1:200
  for i = 1:nTests
    harshes(i) = harshGame(inds{i}, inds{i+1}, param);
  end
  if harshes ~= harshesOld % test determinism
    isOk = 0;
    disp('Test not Ok');
  end
  harshesOld = harshes;
end

disp('The harsh numbers:');
disp(harshes);

%% Display resut
if ~isinteger(harshes) % test integer
  isOk = 0;
  disp('Not integer.');
end

if find(isOk ~=1)
  disp ('Test not OK.');
else
  disp ('Tets OK.');
end


