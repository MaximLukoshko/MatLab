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

h = 0.1;
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

    for i = 1:i_max 
        for j = 1:j_max
            if i == 1
                if j == 1
                    Temp_help =  0.5 * (Temperatures(1, 2) + Temperatures(2, 1));
                end
                
                if j > 1 && j < j_max
                    Temp_help = 0.5 * (0.5 * (Temperatures(j - 1, 1) + Temperatures(j + 1, 1)) + Temperatures(j, 2));     
                end      
                
                if j == j_max
                    Temp_help =  0.5 * (Temperatures(j_max, 2) + Temperatures(j_max - 1, 1));
                end
            end
            
            if i > 1 && i < i_max
                if j>1 && j < j_max
                    Temp_help = 0.25 * (Temperatures(j - 1, i) + Temperatures(j + 1, i) + Temperatures(j, i - 1) + Temperatures(j, i + 1));        
                end
                
                if j == 1
                     Temp_help = 0.5 * (0.5 * (Temperatures(1, i - 1) + Temperatures(1, i + 1)) + Temperatures(2, i));
                end

                if j == j_max
                     Temp_help = 0.5 * (0.5 * (Temperatures(j_max, i - 1) + Temperatures(j_max, i + 1)) + Temperatures(j_max - 1, i));  
                end
            end           
         
            if i == i_max
                if j == j_max
                    Temp_help =  0.5 * (Temperatures(j_max - 1, i_max) + Temperatures(j_max, i_max - 1));
                end
                
                if j < j_max && j > 1
                    Temp_help = 0.5 * (0.5 * (Temperatures(j - 1, i_max) + Temperatures(j + 1, i_max)) + Temperatures(j, i_max - 1));     
                end
                
                if j == 1
                    Temp_help =  0.5 * (Temperatures(2, i_max) + Temperatures(1, i_max - 1));
                end
            end
            
            if i == 1 && j < j_max - j_max_left + 1 || i > 1 && i < i_max || i == i_max && j > j_max - j_min_right - 1
                delta = Lambda * (Temp_help - Temperatures(j, i));
                Temperatures(j, i) = Temperatures(j, i) + delta;
                delta = abs(delta);
                if delta > deltaMax
                    deltaMax = delta;
                end
            end
        end
    end
    
    num_iter = num_iter + 1; 
end



figure;
disp(Temperatures);
surf(Temperatures,'EdgeColor', 'None');

F_in = 0;
F_out = 0;

for j=1:j_max
    F_in = F_in + Temperatures(j, 1) - Temperatures(j, 2);
    F_out = F_out + Temperatures(j, j_max) - Temperatures(j, j_max - 1);
    Temperatures(j, i_max+1) = min(TLeft, TRight);
end

conservatism = abs(F_in + F_out) / (abs(F_in)+abs(F_out));
disp(num2str(conservatism));

figure;
surf(Temperatures,'EdgeColor', 'None');
view(2);



