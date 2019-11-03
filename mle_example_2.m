close all
m = 3;
Ns = 200;
x = randn(Ns,1)+m;
ms= -4:0.0001:10;
for i=1:length(ms)
    y(i) = -0.5*(x-ms(i))'*(x-ms(i));
end
%subplot(3,1,1)
%plot(ms,exp(y)./max(exp(y)),'linewidth',3);hold on
%plot(x,0.001*randn(size(x)),'x','markersize',12,'linewidth',3);
%plot(3,0,'ro','linewidth',3,'markersize',12)
grid on
xlabel('m')
ylabel('likelihood')
title(['N=' num2str(Ns)])
set(gca,'fontsize', 18)
grid minor

xpts = linspace(0, 1, 1000);
l = Logistic_NormalPDF(linspace(0, 1, 1000), 1.0006, 0.4665);
plot(xpts, l);
m = mean(l, 'omitnan');
ex2 = mean(l.^2, 'omitnan');

disp(ex2 - m);

function logit = calc_logit(x)
logit = log(x ./ (1 - x ));
end

function lognormal = Logistic_NormalPDF(x, mu, sigma)
lognormal = (1 ./ (sigma .* sqrt(2*pi))).* (1./(x .* (1-x))) .* exp(-(calc_logit(x) - mu).^2 / (2 .* sigma^2));
end

function PDF = Scaled_BetaPDF(y, a, b, p, q)
PDF = ( (y-p).^(a-1) .* (q - y).^(b-1) ) ./ ( (q - p).^(a+b-1) .* beta(a,b) );
end