% mutateSplit.m splits a players genome in two and
%returns the first half with p=0.5 and secon half with p=0.5

function  rGenome  = mutateSplit(aGenome)
[leangth discard]=size(aGenome);

if rand<0.5
    for i=1:leangth/2
        tempGenome(i)=aGenome(i);
    end
else
    i=1;
    for j=(leangth/2+1):leangth
        tempGenome(i)=aGenome(j);
        i=i+1;
    end
end
rGenome=tempGenome;
end