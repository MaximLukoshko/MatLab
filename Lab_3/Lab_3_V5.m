M = 12000;

X = rand(M, 1);

for i=1:length(X)
    X(i)=(-5)*log(1-X(i));
end


step_theor_X = (ceil(max(X))-floor(min(X)))/100;
Y = floor(min(X)):step_theor_X:ceil(max(X));

pdf_theory = zeros(1,length(Y));

for i=1:length(Y)
    pdf_theory(i) = 0.2 * (expm(-Y(i)/5));
end

MathExpTheor=5;
DispTheor=25;
test_of_distribution(X,pdf_theory,Y,MathExpTheor,DispTheor);