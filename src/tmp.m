dx = .2;
xLim = 200;
x = 0:dx:xLim-1;

y = 5*sin(0.4*pi*x)+randn(size(x));  % Sinusoid with noise

SG0 = smooth1d(y, 4, 21);

% subplot(3,1,1);
plot([y(1:length(SG0))', SG0'])
legend('Noisy Sinusoid','S-G Smoothed sinusoid')

% subplot(3, 1, 2);
% plot([DiffD1',SG1'])
% legend('Diff-generated 1st-derivative', ...
% 'S-G Smoothed 1st-derivative')
% 
% subplot(3, 1, 3);
% plot([DiffD2',SG2'])
% legend('Diff-generated 2nd-derivative',...
% 'S-G Smoothed 2nd-derivative')
