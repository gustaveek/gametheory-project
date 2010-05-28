% driverHarshGame.m Test script for the harsh function

param = s

%% Test for floating point numbers. 
nTests = 100;
inds = cell{nTests+1, 1}
for i = 1:nTests+1
  inds{i} = rand(1, randi(1, 64));
end

hashes  = zeros(1, nTests);
for i = 1:nTests
  hashes(i) = hashGame(inds(i), inds(i+1), param);
