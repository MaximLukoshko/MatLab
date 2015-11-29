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
eps = 0.01;
Lambda = 1.7;

h = 0.4;
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
delta = 0;

while num_iter < MAX_ITER && deltaMax > eps
    deltaMax = 0;
    for j = 2:j_max - j_max_left
            Temp_help = 0.5 * (0.5 * (Temperatures(j - 1, 1) + Temperatures(j + 1, 1)) + Temperatures(j, 2));    
            delta = Lambda * (Temp_help - Temperatures(j, 1));
            Temperatures(j, 1) = Temperatures(j, 1) + delta;
            delta = abs(delta);
            if delta > deltaMax
                deltaMax = delta;
            end
    end
        
    Temp_help =  0.5 * (Temperatures(1, 2) + Temperatures(2, 1));
    delta = Lambda * (Temp_help - Temperatures(1, 1));
    Temperatures(1, 1) = Temperatures(1, 1) + delta;
    delta = abs(delta);
    if delta > deltaMax
        deltaMax = delta;
    end
    
    for i = 2:i_max -1 
        for j = 2:j_max - 1
            Temp_help = 0.25 * (Temperatures(j - 1, i) + Temperatures(j + 1, i) + Temperatures(j, i - 1) + Temperatures(j, i + 1));    
            delta = Lambda * (Temp_help - Temperatures(j, i));
            Temperatures(j, i) = Temperatures(j, i) + delta;
            delta = abs(delta);
            if delta > deltaMax
                deltaMax = delta;
            end
        end
    end
    
    for i = 2:i_max - 1
            Temp_help = 0.5 * (0.5 * (Temperatures(j_max, i - 1) + Temperatures(j_max, i + 1)) + Temperatures(j_max - 1, i));    
            delta =  Lambda * (Temp_help - Temperatures(j_max, i));
            Temperatures(j_max, i) = Temperatures(j_max, i) + delta;
            delta = abs(delta);
            if delta > deltaMax
                deltaMax = delta;
            end
            
            Temp_help = 0.5 * (0.5 * (Temperatures(1, i - 1) + Temperatures(1, i + 1)) + Temperatures(2, i));
            delta = Lambda * (Temp_help - Temperatures(1, i));
            Temperatures(1, i) = Temperatures(1, i) + delta;        
            delta = abs(delta);
            if delta > deltaMax
                deltaMax = delta;
            end
    end
    
    for j = j_max - j_min_right + 1:j_max - 1
            Temp_help = 0.5 * (0.5 * (Temperatures(j - 1, i_max) + Temperatures(j + 1, i_max)) + Temperatures(j, i_max - 1));    
            delta = Lambda * (Temp_help - Temperatures(j, i_max));
            Temperatures(j, i_max) = Temperatures(j, i_max) + delta;
            delta = abs(delta);
            if delta > deltaMax
                deltaMax = delta;
            end
    end
    
    Temp_help =  0.5 * (Temperatures(j_max - 1, i_max) + Temperatures(j_max, i_max - 1));
    delta = Lambda * (Temp_help - Temperatures(j_max, i_max));
    Temperatures(j_max, i_max) = Temperatures(j_max, i_max) + delta;
    delta = abs(delta);
    if delta > deltaMax
        deltaMax = delta;
    end
    num_iter = num_iter + 1; 
end

disp(deltaMax);

figure;
disp(Temperatures);
surf(Temperatures,'EdgeColor', 'None');

for j=1:j_max
    Temperatures(j, i_max+1) = min(TLeft, TRight);
end
figure;
surf(Temperatures,'EdgeColor', 'None');
view(2);