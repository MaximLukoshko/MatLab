close all
clear all

M = 12000;

% disp([num2str(X) ' ' num2str(Y)]);

X = rand();
Y = rand();

Realisation = zeros(1,M);
0
for i=1:length(Realisation);
   
% % % % % % % % % % % % % % % % % % % % % % %     
% Ограничиваем линейной функцией сверху
    X = 3  - sqrt(4 - 3 * rand());
    Y = 3 - 2 * expm(- rand() * 2 / 3);
    
     while (Y > 1 / (X * log(2)))
        X = 3  - sqrt(4 - 3 * rand());
        Y = 3 - 3 * expm(- rand() / (2 * log(2)));

     end
    Realisation1(i) = expm(rand() * log(2));
% % % % % % % % % % % % % % % % % % % % % % % 

% % % % % % % % % % % % % % % % % % % % % % % 
% Ограничиваем максимальным значением
    X = 1 + rand();
    Y = rand() / (log(2));

     while (Y > 1 / (X * log(2)))
            X = 1 + rand();
            Y = rand() / (log(2));
     end
    Realisation(i) = X;
% % % % % % % % % % % % % % % % % % % % % % % 

end

test_of_distribution(Realisation, 'g(x) = 1 / ln(2)');
test_of_distribution(Realisation1, 'g(x)= - (x - 1) / (2 * ln(2)) + 1 / ln(2)');
