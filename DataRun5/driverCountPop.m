% driverCountPop.m. Driver script for the countPop.m file.

%%% Test 1
%% Create a population.
nInd = 30;
population = cell(nInd, 1);
for i = 1:numel (population)
  population{i} = rand(1, randi(10));
end

%% Perform count.
isOk = true;
[indiv freq] = countPop (population);
if (sum(freq)  ~= nInd )
  isOk = false;
end

%% Display result
disp( 'Original population');
for i = 1:numel (population)
  disp (population{i});
end
disp ('Resulting counts');
for i = 1:numel(freq)
  disp([num2str(freq(i)) ' of ' num2str(indiv{i})]);
end
disp (['Test OK: ' num2str(isOk)]);

%%% Test 2
%% modifypop
numMod = floor (nInd / 1.5);
mod = randperm (nInd);
mod = mod(1:numMod);
for i = 1:numMod
  population{randi (nInd)} = population{randi (nInd)};
end

%% Display orig pop
disp( 'Original population');
for i = 1:numel (population)
  disp (population{i});
end

%% Perform count.
isOk = true;
[indiv freq] = countPop (population);
if (sum(freq)  ~= nInd )
  isOk = false;
end

%% Display result
disp ('Resulting counts');
for i = 1:numel(freq)
  disp([num2str(freq(i)) ' of ' num2str(indiv{i})]);
end
disp (['Test OK: ' num2str(isOk)]);


  

  





  
