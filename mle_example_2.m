close all
m = 3;
Ns = 200;
x = randn(Ns,1)+m;
ms= -4:0.0001:10;
for i=1:length(ms)
    y(i) = -0.5*(x-ms(i))'*(x-ms(i));
end
%subplot(3,1,1)
plot(ms,exp(y)./max(exp(y)),'linewidth',3);hold on
%plot(x,0.001*randn(size(x)),'x','markersize',12,'linewidth',3);
%plot(3,0,'ro','linewidth',3,'markersize',12)
grid on
xlabel('m')
ylabel('likelihood')
title(['N=' num2str(Ns)])
set(gca,'fontsize', 18)
grid minor

