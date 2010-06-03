% mutateDuplicate.m duplicates a players genome and returns it 

function  rDuplicatedGenome = mutateDuplicate(aGenome)


rDuplicatedGenome=[aGenome aGenome];

if size(rDuplicatedGenome,2)==4
rDuplicatedGenome=aGenome;
end

end