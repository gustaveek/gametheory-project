% genStateTable generates the state table and returns a matrix of size (leangth of longest memory)*2
%
%
function  rStateTable = genStateTable(aVectorP1 , aVectorP2)

aVectorP1=aVectorP1';
aVectorP2=aVectorP2';

[vectorLeangth1, temp]= size(aVectorP1);
[vectorLeangth2, temp]= size(aVectorP2);
s=[];
t=[];


if vectorLeangth1<=4 && vectorLeangth2<=4
    
    %we fill player ones s-vector with values:
    
    if vectorLeangth1==1 %equals memory zero
        s=[aVectorP1;aVectorP1;aVectorP1;aVectorP1];
    end
    if vectorLeangth1==2 %equals memory leangth one
        s=[aVectorP1;aVectorP1];
    end
    if vectorLeangth1==4 %equals memory leangth two
        s=[aVectorP1];
    end
    
    %gives player two values into its t-vector ( this means a lot of switching
    %of places. Could most probably be done in a better way)
    
    if vectorLeangth2==1 %equals memory zero
        t=[aVectorP2;aVectorP2;aVectorP2;aVectorP2];
    end
    if vectorLeangth2==2 %equals memory leangth one
        t=[aVectorP2(1);aVectorP2(1);aVectorP2(2);aVectorP2(2)];
    end
    if vectorLeangth2==4 %equals memory leangth two
        t=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)];
    end
    
end
%----------------------------------------------------------------
if vectorLeangth1>4 || vectorLeangth2>4
    
    iter=16;
    
    if vectorLeangth1==1 %equals memory zero
        
        for i= 1:iter
            s(i)=(aVectorP1);
        end
        
    end
    if vectorLeangth1==2 %equals memory leangth one
        for i=1:iter/2
            s(i)=aVectorP1(1);
            s(i+1)=aVectorP1(2);
        end
    end
    
    if vectorLeangth1==4 %equals memory leangth two
        s=[aVectorP1;aVectorP1;aVectorP1;aVectorP1];
    end
    
    if vectorLeangth1==8 %equals memory leangth three
        s=[aVectorP1; aVectorP1];
    end
    if vectorLeangth1==16 %equals memory leangth four
        s=[aVectorP1];
    end
    
    %gives player two values into its t-vector ( this means a lot of switching
    %of places. Could most probably be done in a better way)
    
    if vectorLeangth2==1 %equals memory zero
        
        for i= 1:iter
            t(i)=(aVectorP2);
        end
        t=t';
    end
    if vectorLeangth2==2 %equals memory leangth one
        for i=1:iter/2
            
            temp=[aVectorP2(1);aVectorP2(1);aVectorP2(2);aVectorP2(2)]; %flip number 2 and 3
            
            t=[temp;temp;temp;temp];
        end
    end
    
    if vectorLeangth2==4 %equals memory leangth two
        temp=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        t=[temp;temp;temp;temp];
        
    end
    
    if vectorLeangth2==8 %equals memory leangth three
        temp1=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        temp2=[aVectorP2(5);aVectorP2(7);aVectorP2(6);aVectorP2(8)]; %flips number 6 and 7
        t=[temp1;temp2;temp1;temp2];
    end
    
    if vectorLeangth2==16 %equals memory leangth four
        temp1=[aVectorP2(1);aVectorP2(3);aVectorP2(2);aVectorP2(4)]; %flips number 2 and 3
        temp2=[aVectorP2(5);aVectorP2(7);aVectorP2(6);aVectorP2(8)];%flips number 6 and 7
        temp3=[aVectorP2(9);aVectorP2(11);aVectorP2(10);aVectorP2(12)];%flips number 10 and 11
        temp4=[aVectorP2(13);aVectorP2(15);aVectorP2(14);aVectorP2(16)];%flips number 14 and 15
        t=[temp1;temp3;temp2;temp4];% flip temp2 and temp3
        
    end
    
end

rStateTable=[s,t];

return
%end