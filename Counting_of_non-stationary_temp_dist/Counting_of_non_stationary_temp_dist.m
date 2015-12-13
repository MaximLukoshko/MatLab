close all
clear all

% Initial Condition
% TLeft = 160.0; 
% TRight = 350.0;
A = 25;
TStart = 200.0;
TFinish = 160.0;
tau_1 = 50;
tau_2 = 50;
WIDTH = 100; 
HEIGHT = 3; 
HeightLeftZone = 1; 
HeightRightZone = 0;

% Stop Parametres
MAX_ITER = 10000;
eps = 0.001;
Lambda = 1.7;

% Sharing to zones
h = 0.4;
i_max = floor(WIDTH / h);
j_max = floor(HEIGHT / h);
j_max_left = floor(HeightLeftZone / h) ;
j_min_right = j_max - ceil(HeightRightZone / h);

% Matrix of temperaturies
Temperatures = zeros(j_max, i_max);
for k = 1:j_max_left
   Temperatures(k, 1) = TStart; 
end

% T=a*tau
a = zeros(2);
a(1) = TFinish / tau_1;
a(2) = - TFinish / (2 * tau_2);

%  Time step
num_tau_step = 20;
tau_step = zeros(2);
tau_step(1) = tau_1 / num_tau_step;
tau_step(2) = tau_2 / num_tau_step;

% Creating matrixes for SLAE
num_var = i_max * j_max;
system_dimension = num_var - j_max_left - j_max + j_min_right;
SystemMatrix = zeros(system_dimension, system_dimension);
RightPartColumn = zeros(system_dimension);
X = zeros(system_dimension);
INDEX = 1;

for part = 1:2
    for cur_k = 1:num_tau_step
    for k = 1:j_max_left
       Temperatures(k, 1) = Temperatures(k, 1) + a(part) * tau_step(part); 
    end
    INDEX = 1;
        for i = 1:i_max 
            for j = 1:j_max
                % Choosing the template
                if i == 1                  
                    if j > j_max_left + 1 && j < j_max
                        SystemMatrix(INDEX, INDEX) = 0.5 * h * h + 2 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + j_max) = - tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.5 * h * h * Temperatures(j, i); 
                        INDEX = INDEX + 1;
                        continue
                    end      
                    
                    if j == j_max_left + 1 
                        SystemMatrix(INDEX, INDEX) = 0.5 * h * h + 2 *tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX + 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + j_max) = - tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.5 * h * h * Temperatures(j, i) + 0.5 * tau_step(part) * A * Temperatures(j_max_left, 1); 
                        INDEX = INDEX + 1;
                        continue
                    end   
                    
                    if j == j_max
                        SystemMatrix(INDEX, INDEX) = 0.25 * h * h + tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + j_max) = - 0.5 * tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.25 * h * h * Temperatures(j, i);
                        INDEX = INDEX + 1;
                        continue
                    end
                end
                
                if i > 1 && i < i_max
                    if j > 1 && j < j_max
                        SystemMatrix(INDEX, INDEX) = h * h + 4 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + 1) = - tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + j_max) = - tau_step(part) * A;
                        RightPartColumn(INDEX) = h * h * Temperatures(j, 1);
                        
                        if i > 2 || j > j_max_left
                            SystemMatrix(INDEX, INDEX - j_max) = - tau_step(part) * A;
                        end
                        
                        if i == 2 && j <= j_max_left
                            RightPartColumn(INDEX) = RightPartColumn(INDEX) + tau_step(part) * A * Temperatures(j_max_left, 1);
                        end
                    end
                    
                    if j == 1 
                        SystemMatrix(INDEX, INDEX) = 0.5 * h * h + 2 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX + 1) = - tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX + j_max) = - 0.5 * tau_step(part) * A;
                        RightPartColumn(INDEX) = 0.5 * h * h * Temperatures(j, 1);
                        if i > 2
                             SystemMatrix(INDEX, INDEX - j_max) = - 0.5 * tau_step(part) * A;
                        end
                        
                        if i == 2
                            RightPartColumn(INDEX) = RightPartColumn(INDEX) + 0.5 * tau_step(part) * A * Temperatures(j_max_left, 1);
                        end
                    end
                    
                    if j == j_max
                        SystemMatrix(INDEX, INDEX) = 0.5 * h * h + 2 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX - j_max) = - 0.5 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX + j_max) = - 0.5 * tau_step(part) * A;
                        RightPartColumn(INDEX) = 0.5 * h * h * Temperatures(j, 1);
                    end
                    
                    INDEX = INDEX + 1;
                    continue
                end           
             
                if i == i_max
                    if j == j_max
                        SystemMatrix(INDEX, INDEX) = 0.25 * h * h + tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX - j_max) = - 0.5 * tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.25 * h * h * Temperatures(j, i);
                    end
                    
                    if j < j_max && j > 1
                        SystemMatrix(INDEX, INDEX) = 0.5 * h * h + 2 * tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX - 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX + 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX - j_max) = - tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.5 * h * h * Temperatures(j, i); 
                    end
                    
                    if j == 1
                        SystemMatrix(INDEX, INDEX) = 0.25 * h * h + tau_step(part) * A;
                        SystemMatrix(INDEX, INDEX + 1) = - 0.5 * tau_step(part) * A; 
                        SystemMatrix(INDEX, INDEX - j_max) = - 0.5 * tau_step(part) * A; 
                        RightPartColumn(INDEX) = 0.25 * h * h * Temperatures(j, i);
                    end
                    
                    INDEX = INDEX + 1;
                    continue
                end
            end
        end

        X = linsolve(SystemMatrix, RightPartColumn);
    
        % Replacing temperatures
        INDEX = 1;
        for j = j_max_left+1:j_max
            Temperatures(j, 1) = X(INDEX);
            INDEX = INDEX + 1;
        end
        
        for i = 2:i_max
            for j = 1:j_max
                Temperatures(j, i) = X(INDEX);
                INDEX = INDEX + 1;
            end
        end
        
        figure;
        surf(Temperatures,'EdgeColor', 'None');
%         view(2);
    end
end

disp(Temperatures);

figure;
surf(Temperatures);

figure;
surf(Temperatures,'EdgeColor', 'None');
view(2);




