function []=solve_fourth_point(x,M,N,pos, MU,SIGMA,LAMBDA, x_hist,x_step, pdf_theory, cdf_theory,TITLE)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp([TITLE ':']);
disp(' ');

disp([ num2str(N) ' values, starting from position ' num2str(pos) ':']);
disp(x(pos:pos+N));
disp(['Range [min max]: [' num2str(min(x)) ' ' num2str(max(x)) '];']);

% disp(mean(x));

K=[32,64,128,256,316,632,1000,2000,3162,5000,7000,9000,M];
lenth_K=length(K);

MeansExplorering = zeros(1,lenth_K);
SigmaExplorering = zeros(1,lenth_K);
mu = zeros(1,lenth_K);
sigma = zeros(1,lenth_K);

for i=1:length(K)
    MeansExplorering(i)=mean(x(1:K(i)));
    SigmaExplorering(i)=std(x(1:K(i)));
    mu(i)=MU;
    sigma(i)=SIGMA;
end

% disp(K);
% disp(MeansExplorering);

figure;
plot(log10(K),mu, 'g','LineWidth', 3);
hold on;
plot(log10(K),MeansExplorering,'r+-','MarkerEdgeColor', 'b');
xlabel('K');
ylabel('Mathematical expectation');
title(TITLE);
grid('ON');

figure;
plot(log10(K),sigma, 'g','LineWidth', 3);
hold on;
plot(log10(K),SigmaExplorering,'r+-','MarkerEdgeColor', 'b');
xlabel('K');
ylabel('sigma');
title(TITLE);
grid('ON');

disp(['The Median of ' TITLE 'is ' num2str(median(x))]);
disp(['The Mode of ' TITLE 'is ' num2str(mode(x))]);


figure;
hist_estim = hist(x, x_hist);
hist_estim = hist_estim/(length(x)*x_step);
% disp(hist_estim);
hold on;
bar(x_hist,hist_estim);
plot(x_hist, hist_estim,'b');
title(['Probability Distribution for ' TITLE]);
hold off;

figure;
hold on;
plot(x_hist, hist_estim,'b');
plot(sort(x), pdf_theory,'g');
% title(['PDF for ' TITLE ' distribution']);
hold off;

figure;
hist_estim=hist_estim*x_step;
hist_cum = cumsum(hist_estim);
hold on
stairs(x_hist, hist_cum, 'r');
plot(sort(x), cdf_theory, 'b');
hold off;
title(['CDF for ' TITLE ' distribution']);
% xlabel('value');
% ylabel('CDF');
grid on;

end

