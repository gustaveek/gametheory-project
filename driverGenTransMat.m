% driverGenTranMat.m Driver script for genTransMat
%
% Use first both tit for tat. 
%
%     Table           Matrix
%   pI      pII       dd dc cd cc
%    0  dd   0     dd  1  0  0  0
%    1  dc   0	   dc  0  0  1  0
%    0  cd   1     cd  0  1  0  0                            	    
%    1  cc   1     cc  0  0  0  1                            	    
% 

% test prob == 0
param = struct( 'pError', 0.0);

% 1) two tit for tat
table1 = [0 0;
	  1 0;
	  0 1;
	  1 1];
expMat1 = [1 0 0 0;
	   0 0 1 0;
	   0 1 0 0;
	   0 0 0 1];

outMat1 = genTransMat (table, param);

% 2) tow tit for tat, double chromosome
table2 = [0 0
	  1 0
	  0 1
	  1 1

	  0 0
	  1 0
	  0 1 
	  1 1

	  0 0
	  1 0
	  0 1
	  1 1

	  0 0
	  1 0
	  0 1
	  1 1];



if (outMat == expMat)
  disp('Test OK.');
else
  disp('Test not OK. Expected:');
  disp(expMat);
  disp('Result');
  disp(outMat);
end
