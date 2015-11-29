close all
clear all

a = 25;
TLeft = 160.0; 
TRight = 350.0; 
WIDTH = 20; 
HEIGHT = 12; 
HeightLeftZone = 10; 
HeightRightZone = 7;

MAX_ITER = 10000;
eps = 0.001;
Lambda = 1.7;

h = 1;
i_max = floor(WIDTH / h);
j_max = floor(HEIGHT / h);
j_max_left = floor(HeightLeftZone / h) ;
j_min_right = j_max - ceil(HeightRightZone / h);

Temperatures = repmat(TRight, j_max, i_max);

for k = j_max - j_max_left + 1:j_max
   Temperatures(k, 1) = TLeft; 
end



deltaMax = 1 + eps;
num_iter = 0;
Temp_help = 0;

while num_iter < MAX_ITER && deltaMax > eps
    for j = 2:j_max - 1
        for i = 2:i_max -1 
            Temp_help = 0.25 * (Temperatures(j - 1, i) + Temperatures(j + 1, i) + Temperatures(j, i - 1) + Temperatures(j, i + 1));    
            Temperatures(j, i) = Temperatures(j, i) + Lambda * (Temp_help - Temperatures(j, i));
        end
    end
    num_iter = num_iter + 1; 
end

disp(Temperatures);

surf(Temperatures);