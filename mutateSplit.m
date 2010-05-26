% mutateSplit.m splits a players genome in two and
%returns the first half with p=0.5 and secon half with p=0.5

function  rGenome  = mutateSplit(aGenome)
length=size(aGenome,1);

if length==1
    rGenome=aGenome;
    return
end

if mod(length,2)
    error('kromosom inskickad till mutateSplit ej delbar med två')
end
tempGenome=zeros(length/2,1);
if rand<0.5
    for i=1:length/2
        tempGenome(i)=aGenome(i);
    end
else
    i=1;
    for j=(length/2+1):length
        tempGenome(i)=aGenome(j);
        i=i+1;
    end
end
rGenome=tempGenome;
end