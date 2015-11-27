close all
clear all

Lambda = 0.5;
OmegaLeft = 0;
OmegaRight = 5;
M=1000;
Intervals=zeros(1,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:M
    Intervals = model(Lambda, OmegaLeft, OmegaRight, M);
end
disp(Intervals);

k=1:1:M;
Events_Density_pract =  Intervals ./ ((OmegaRight-OmegaLeft));
Events_Density_theor = Lambda .* ones(1,length(k));

figure
hold on
plot(k, Events_Density_pract);
plot(k, Events_Density_theor, 'g', 'LineWidth', 5);
title('Intensity');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=0:1:10;


PDF_theor = poisspdf(k, Lambda * (OmegaRight-OmegaLeft));

step = (OmegaRight-OmegaLeft);

PDF_pract = hist(Intervals, k);
PDF_pract = PDF_pract ./ length(Intervals);


figure
hold on
bar(k , PDF_pract);
plot(k , PDF_theor, 'g', 'LineWidth', 5)
title('PDF');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp('Hi');
