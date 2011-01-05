function y = smooth1d(x, N, F)
% function y = smooth1d(x, N, F)
[b,g] = sgolay(N,F);   % Calculate S-G coefficients

HalfWin  = ((F+1)/2) -1;
for n = (F+1)/2:length(x)-(F+1)/2,
  % Zero-th derivative (smoothing only)
  y(n) =   dot(g(:,1), x(n - HalfWin: n + HalfWin));
end