% driverGenTranMat.m Driver script for genTransMat
%
% Use first both tit for tat, which is do the oposit
%
%     Table           Matrix from
%   pI      pII         dd dc cd cc
%    0  dd   0       dd  1  0  0  0
%    1  dc   0	  to dc  0  0  1  0
%    0  cd   1       cd  0  1  0  0                            	    
%    1  cc   1       cc  0  0  0  1                            	    
%  
% Uses cell arrray for to store test table, expected matrix, and 
% output matrix. 


clear all;

% test prob == 0
param = struct( 'pError', 0.0);
 param.pError = 0.03; %rand(1);




numTests = 3;
tables  = cell(numTests,1);
expMats = cell(numTests,1);
outMats = cell(numTests,1);
isOk = ones(1, numTests);


% 1) two tit for tat
tables{1} = [0 0;
	  1 0;
	  0 1;
	  1 1];
expMats{1} = [1 0 0 0;
	   0 0 1 0;
	   0 1 0 0;
	   0 0 0 1];
outMats{1} = genTransMat (tables{1}, param);

% 2) tow tit for tat, double chromosome
tables{2} = [tables{1}; tables{1}; tables{1}; tables{1}];
expMats{2} = zeros(size(tables{2}));
for z = 1:4, 
  expMats{2}( 1, (4*(z-1) + 1)) = 1;
  expMats{2}( 7, (4*(z-1) + 2)) = 1;
  expMats{2}(10, (4*(z-1) + 3)) = 1;
  expMats{2}(16, (4*(z-1) + 4)) = 1;
end
outMats{2} = genTransMat (tables{2}, param);

% 3) Random table size 16. Do not test output matrix agains expected matrix
tables{3} = rand (64, 2);
outMats{3} = genTransMat(tables{3}, param);


% test: compare to expeced version
for i = 1:2
  if find (outMats{i} - expMats{i}) % then not OK
    isOk(i) = 0;
    disp (['Test ' num2str(i) ', output, not OK.']);
    disp ('Table:');
    disp (tables{i});
    disp ('Expected:');
    disp (expMats{i});
    disp ('got');
    disp (outMats{i});
  else
    isOk(i) = 1;
  end
end

% test: check sum
prec = 2.22e-15;
for i = 1:numTests
  sums = sum (outMats{i}, 1);
  if find (abs(sums - 1.0) > prec)
    isOk(i) = 0;
    disp (['Test ' num2str(i) ', sum, not OK.']);
    disp ('Sums:');
    disp (sums);
    disp ('Table:');
    disp (tables{i});
    disp ('Output marix:');
    disp (outMats{i});
  else
    isOk(i) = 1;
  end
end

if find( isOk ~= 1 )
  disp ('Test not OK.');
  disp (isOk);
else
  disp('Test OK.');
end
