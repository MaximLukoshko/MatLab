function [] = Sum_of_K_random_quantities(x_sum_K,K)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x_step = K/50;
x_hist=0+x_step/2:x_step:12-x_step/2;

histogram = hist(x_sum_K, x_hist);

histogram = histogram/(length(x_sum_K)*x_step);

pdf_theory = normpdf(x_hist,K/2,1);

figure;
hold on
plot(x_hist, histogram, 'r');
plot(x_hist, pdf_theory, 'b');
hold off
title(['Sum of ' num2str(K) ' uniform distributions']);
xlabel('value');
ylabel('PDF');
grid on;


end

