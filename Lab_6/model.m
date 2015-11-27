function [y] = model(Lambda, OmegaLeft, OmegaRight, M)


Events=zeros(1,1);


j=1;
while j<=M
    i=1;
    t=OmegaLeft;
    k=-1;
    while t<OmegaRight
%         Events(i)=t;
        i=i+1;
        k=k+1;
        t = t - log(rand())/Lambda;
    end
    Events(j) = k;
    j=j+1;
end

 y=Events;
end

