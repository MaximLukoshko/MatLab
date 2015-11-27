function []=test_of_distribution(x, prob, TITLE)

disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(TITLE);
% disp(' ');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
a=min(x);
b=max(x);
x_hist=a:1:(length(prob)-1);

x_hist(1)=1;
x_hist_fact = cumprod(x_hist);
x_hist(1)=0;

hist_estim = hist(x, x_hist);
hist_estim = hist_estim/length(x);

z = (log(2) .^ x_hist) ./ (2 .* x_hist_fact);

figure;
hold on;
bar(x_hist, hist_estim,'b');
plot(x_hist,z,'r');
title(['PDF for your distribution      # ' TITLE ' #']);
xlabel('X');
ylabel('PDF');
grid('ON');
hold off;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 




disp(' ');
disp(' ');




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
MathExpTheor = log(2);
disp(['The value of mathematical expectation of your distribution, counted using mean(): ' num2str(mean(x))]);
disp(['The theoretical value of mathematical expectation: ' num2str(MathExpTheor)]);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



disp(' ');
disp(' ');





% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
DispTheor = log(2);
disp(['The value of dispersion of your distribution, counted using var(): ' num2str(var(x))]);
disp(['The theoretical value of dispersion: ' num2str(DispTheor)]);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



disp(' ');
disp(' ');



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
N = length(x);
hist_estim_theoretical = z;
hist_estim_practical = hist_estim .* N;

r = length(x_hist);
betta = 0.95;
chi2_pract = 0;
chi2_theor = 0;

for i=1:length(x_hist)
   chi2_pract = chi2_pract + ((hist_estim_practical(i) - N * z(i)) ^ 2) / z(i);
end
chi2_pract = chi2_pract / N;
chi2_theor = chi2inv(betta,r-1);

disp(['Theoretical value of chi^2 for beta=' num2str(betta) ' and r-1=' num2str(r-1) ' is ' num2str(chi2_theor) ]);
disp(['Practical value of chi^2 for r-1=' num2str(r-1) ' is ' num2str(chi2_pract) ]);

if chi2_pract<chi2_theor
    disp(['The theory is well enough according to this criterion (' num2str(chi2_pract) '<' num2str(chi2_theor) ')']);
else
    disp(['The theory is not well enough according to this criterion (' num2str(chi2_pract) '>' num2str(chi2_theor) ')']);
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


end

