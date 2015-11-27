function []=test_of_distribution(x, TITLE)

disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(TITLE);
disp(' ');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
a=floor(min(x));
b=ceil(max(x));
x_step = (b-a)/25;
x_hist = a + x_step / 2 : x_step : b - x_step / 2;
hist_estim = hist(x, x_hist);
hist_estim = hist_estim/(length(x)*x_step);

y=1:0.02:2;
z = zeros(1,length(y));
for i=1:length(z);
    z(i)=1/(log(2)*y(i));
end

figure;
hold on;
plot(x_hist, hist_estim,'b');
plot(y,z,'g');
title(['PDF for your distribution      # ' TITLE ' #']);
xlabel('X');
ylabel('PDF');
grid('ON');
hold off;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 






% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
hist_estim_theoretical = zeros(1,length(x_hist));
hist_estim_practical = hist(x,x_hist);

for i=1:length(x_hist)
    hist_estim_theoretical(i) = length(x) * log((x_hist(i) + x_step / 2) / (x_hist(i) - x_step / 2)) / log(2);
end

r = 25;
betta = 0.95;
chi2_pract = 0;
chi2_theor = 0;

for i=1:r
    chi2_pract=chi2_pract+((hist_estim_practical(i)-hist_estim_theoretical(i))^2)/(hist_estim_theoretical(i));
end

chi2_theor = chi2inv(betta,r-1);

disp(['Theoretical value of chi^2 for beta=' num2str(betta) ' and r-1=' num2str(r-1) ' is ' num2str(chi2_theor) ]);
disp(['Practical value of chi^2 for r-1=' num2str(r-1) ' is ' num2str(chi2_pract) ]);

if chi2_pract<chi2_theor
    disp(['The theory is well enough according to this criterion (' num2str(chi2_pract) '<' num2str(chi2_theor) ')']);
else
    disp(['The theory is not well enough according to this criterion (' num2str(chi2_pract) '>' num2str(chi2_theor) ')']);
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 




disp(' ');
disp(' ');




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
betta = 0.95;
omega2_pract = 1/(12*length(x));
omega2_theor = 0.46;
x_sorted = sort(x);
x_sorted_length = length(x_sorted);

for i=1:x_sorted_length
    omega2_pract=omega2_pract + (log(x_sorted(i))/log(2) - (i - 1 / 2) / x_sorted_length) ^ 2;
end

disp(['Theoretical value of omega^2 for beta=' num2str(betta) ' is ' num2str(omega2_theor) ]);
disp(['Practical value of omega^2 is ' num2str(omega2_pract) ]);
if omega2_pract<omega2_theor
    disp(['The theory is well enough according to this criterion (' num2str(omega2_pract) '<' num2str(omega2_theor) ')']);
else
    disp(['The theory is not well enough according to this criterion (' num2str(omega2_pract) '>' num2str(omega2_theor) ')']);
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

end

