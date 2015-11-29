close all
clear all

TLeft = 160.0; 
TRight = 350.0; 
WIDTH = 20; 
HEIGHT = 12; 
HeightLeftZone = 10; 
HeightRightZone = 7;

h = 1;
i_max = floor(WIDTH / h);
j_max = floor(HEIGHT / h);
j_max_left = floor(HeightLeftZone / h) ;
j_min_right = j_max - ceil(HeightRightZone / h);

Temperatures = zeros(j_max, i_max);

for k=j_max - j_max_left + 1:j_max
   Temperatures(k, 1) = TLeft; 
end

for k=1:j_max - j_min_right;
   Temperatures(k, i_max) = TRight; 
end


disp(Temperatures);