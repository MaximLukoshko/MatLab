M=11000;
N=12;
MU=-3;
SIGMA=2;
LAMBDA=3.0;

pos=1;

X=rand(1,M);

for K=1:12
    
Y=rand(1,M);

Sum_of_K_random_quantities(X,K);
X=X+Y;
end
