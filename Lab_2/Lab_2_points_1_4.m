M=11000;
N=12;
MU=-3;
SIGMA=2;
LAMBDA=3.0;

pos=1;

Poisson=poissrnd(LAMBDA,M,1);       % Распределение Пуассона
Unif=unifrnd(0,1,M,1);              % Равномерное Распределение 
Norm=normrnd(MU,SIGMA,M,1);         % Нормальное Распределение

MU_Unif=0.5;
SIGMA_Unif=sqrt(1/12);
pdf_theory_Unif=unifpdf(sort(Unif));
cdf_theory_Unif=unifcdf(sort(Unif));
Title_Unif='Uniform Distribution';
a=floor(min(Unif));
b=ceil(max(Unif));
x_step = (b-a)/20;
x_hist_Unif = a+x_step/2:x_step:b-x_step/2;
solve_fourth_point(Unif,M,N,pos,MU_Unif,SIGMA_Unif,LAMBDA,x_hist_Unif,x_step,pdf_theory_Unif ,cdf_theory_Unif,Title_Unif);

MU_Norm=MU;
SIGMA_Norm=SIGMA;
cdf_theory_Norm=normcdf(sort(Norm),MU_Norm,SIGMA_Norm);
pdf_theory_Norm=normpdf(sort(Norm),MU_Norm,SIGMA_Norm);
Title_Norm='Normal Distribution';
a=floor(min(Norm));
b=ceil(max(Norm));
x_step = (b-a)/20;
x_hist_Norm = a+x_step/2:x_step:b-x_step/2;
solve_fourth_point(Norm,M,N,pos,MU_Norm,SIGMA_Norm,LAMBDA,x_hist_Norm,x_step,pdf_theory_Norm,cdf_theory_Norm,Title_Norm);

MU_Poiss=LAMBDA;
SIGMA_Poiss=sqrt(LAMBDA);
LAMBDA_Poiss=LAMBDA;
pdf_theory_Poiss=poisspdf(sort(Poisson),LAMBDA_Poiss);
cdf_theory_Poiss=poisscdf(sort(Poisson),LAMBDA_Poiss);
Title_Poiss='Poisson Distribution';
x_hist_Poiss=1:max(Poisson);
solve_fourth_point(Poisson,M,N,pos,MU_Poiss,SIGMA_Poiss,LAMBDA_Poiss,x_hist_Poiss,1,pdf_theory_Poiss,cdf_theory_Poiss,Title_Poiss);
