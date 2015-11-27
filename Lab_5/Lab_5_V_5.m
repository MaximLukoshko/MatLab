close all
clear all

M = 96000;

% j = 0 : 1 : 6;

Probabilities = zeros(1,8);
Probabilities(1) = 0.5;

for i=2:8
   Probabilities(i) = Probabilities(i - 1) * log(2) / (i-1);
end

Probabilities = cumsum(Probabilities);

% disp(j);
% disp(Probabilities);

Realization=rand(1,M);

for i=1:M
    k=1;
   while Probabilities(k)<=Realization(i)
       k=k+1;
   end
   Realization(i)=k-1;
end

test_of_distribution(Realization, Probabilities,'P{X = k} = ((ln2) ^ k) / (2 * k!)')

