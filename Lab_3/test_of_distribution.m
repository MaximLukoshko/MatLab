function []=test_of_distribution(x,pdf_theory, x_theory,MathExpTheor,DispTheor)

a=floor(min(x));
b=ceil(max(x));
x_step = (b-a)/50;
x_hist = a+x_step/2:x_step:b-x_step/2;
hist_estim = hist(x, x_hist);
hist_estim = hist_estim/(length(x)*x_step);

figure;
hold on;
plot(x_hist, hist_estim,'b');
plot(x_theory, pdf_theory,'g');
title(['PDF for your distribution']);
xlabel('X');
ylabel('PDF');
hold off;

sigma=sqrt(DispTheor);
b=0.95;
y_b=norminv(1-(1-b)/2);
MeanExp=mean(x);

disp(['The value of mathematical expectation of your distribution, counted using mean(): ' num2str(MeanExp)]);
disp(['The value of mathematical expectation of your distribution, counted using equation: ' num2str(sum(x)/length(x))]);
disp(['The theoretical value of mathematical expectation: ' num2str(MathExpTheor)]);

disp(' ');

disp(['Confidence interval for the mathematical expectation: [' num2str(MeanExp-y_b*sigma/sqrt(length(x))) ' ; ' num2str(MeanExp+y_b*sigma/sqrt(length(x))) ']']);

disp(' ');

disp(['The value of dispersion of your distribution, counted using var(): ' num2str(var(x))]);
disp(['The value of dispersion of your distribution, counted using equation: ' num2str(sum(x.*x)/(length(x)-1) - (1/(length(x)*(length(x)-1)))*sum(x)*sum(x))]);
disp(['The theoretical value of dispersion: ' num2str(DispTheor)]);
end