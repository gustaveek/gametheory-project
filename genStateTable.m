% genStateTable generates the state table and returns a matrix of size (Length of longest memory)*2
%
%
function  rStateTable = genStateTable(aVectorP1 , aVectorP2)

aVectorP1=aVectorP1';
aVectorP2=aVectorP2';

[vectorLength1, temp]= size(aVectorP1);
[vectorLength2, temp]= size(aVectorP2);
s=[];
t=[];


if vectorLength1<=4 && vectorLength2<=4
    
    %we fill player ones s-vector with values:
    
    if vectorLength1==1 %equals memory zero
        s=[aVectorP1;aVectorP1;aVectorP1;aVectorP1];
    end
    if vectorLength1==2 %equals memory Length one
        s=[aVectorP1;aVectorP1];
    end
    if vectorLength1==4 %equals memory Length two
        s=[aVectorP1];
    end
    
    %gives player two values into its t-vector ( this means a lot of switching
    %of places. Could most probably be done in a better way)
    
    if vectorLength2==1 %equals memory zero
        t=[aVectorP2;aVectorP2;aVectorP2;aVectorP2];
    end
    if vectorLength2==2 %equals memory Length one
        t=[aVectorP2(1);aVectorP2(1);aVectorP2(2);aVectorP2(2)];
    end
    if vectorLength2==4 %equals memory Length two
        t=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)];
    end
    
end
%----------------------------------------------------------------
if vectorLength1>4 || vectorLength2>4
    
    iter=16;
    if vectorLength1==1 %equals memory zero
        
        for i= 1:iter
            s(i,1)=(aVectorP1);
        end
        
    end
    if vectorLength1==2 %equals memory Length one
        
        for i=1:2:iter
            s(i,1)=aVectorP1(1);
            s(i+1,1)=aVectorP1(2);
        end
    end
    
    if vectorLength1==4 %equals memory Length two
        s=[aVectorP1;aVectorP1;aVectorP1;aVectorP1];
    end
    
    if vectorLength1==8 %equals memory Length three
        s=[aVectorP1; aVectorP1];
    end
    if vectorLength1==16 %equals memory Length four
        s=[aVectorP1];
    end
    
    %gives player two values into its t-vector ( this means a lot of switching
    %of places. Could most probably be done in a better way)
    
    if vectorLength2==1 %equals memory zero
        
        for i= 1:iter
            t(i)=(aVectorP2);
        end
        t=t';
    end
    if vectorLength2==2 %equals memory Length one
        for i=1:iter/2
            
            temp=[aVectorP2(1);aVectorP2(1);aVectorP2(2);aVectorP2(2)]; %flip number 2 and 3
            
            t=[temp;temp;temp;temp];
        end
    end
    
    if vectorLength2==4 %equals memory Length two
        temp=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        t=[temp;temp;temp;temp];
        
    end
    
    if vectorLength2==8 %equals memory Length three
        temp1=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        temp2=[aVectorP2(5);aVectorP2(7);aVectorP2(6);aVectorP2(8)]; %flips number 6 and 7
        t=[temp1;temp2;temp1;temp2];
    end
    
    if vectorLength2==16 %equals memory Length four
        temp1=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        temp2=[aVectorP2(5);aVectorP2(7);aVectorP2(6);aVectorP2(8)];%flips number 6 and 7
        temp3=[aVectorP2(9);aVectorP2(11);aVectorP2(10);aVectorP2(12)];%flips number 10 and 11
        temp4=[aVectorP2(13);aVectorP2(15);aVectorP2(14);aVectorP2(16)];%flips number 14 and 15
        t=[temp1;temp3;temp2;temp4];% flip temp2 and temp3
        
    end
   
    if length(s)<16
    error('fel längd på s i genStateTable')
    end
    
    if length(t)<16
    error('fel längd på t i genStateTable')
    end
    
    
end

rStateTable=[s,t];

return
%end