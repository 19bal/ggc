clear all; clc;
dbnm = '../../db/hepsi/';
load(pathos(strcat(dbnm, 'ds/dataset.bak')))
load(pathos(strcat(dbnm, 'ds/dsclass.bak')))

% simdilik egitim ve test orneklerini manuel seciyoruz
egt(1:2, :) = dataset(1:2, :); egt(3:4, :) = dataset(4:5, :);
egt(5:6, :) = dataset(7:8, :); egt(7:8, :) = dataset(10:11, :);
egt(9:10, :) = dataset(13:14, :); egt(11:12, :) = dataset(16:17, :);
egt(13:14, :) = dataset(19:20, :); egt(15:16, :) = dataset(22:23, :);
egt(17:18, :) = dataset(25:26, :); egt(19:20, :) = dataset(28:29, :);

egts(1:2) = dsclass(1:2); egts(3:4) = dsclass(4:5);
egts(5:6) = dsclass(7:8); egts(7:8) = dsclass(10:11);
egts(9:10) = dsclass(13:14); egts(11:12) = dsclass(16:17);
egts(13:14) = dsclass(19:20); egts(15:16) = dsclass(22:23);
egts(17:18) = dsclass(25:26); egts(19:20) = dsclass(28:29);

test(1, :) = dataset(3, :); test(2, :) = dataset(6, :);
test(3, :) = dataset(9, :); test(4, :) = dataset(12, :);
test(5, :) = dataset(15, :); test(6, :) = dataset(18, :);
test(7, :) = dataset(21, :); test(8, :) = dataset(24, :);
test(9, :) = dataset(27, :); test(10, :) = dataset(30, :);

tests(1) = dsclass(3); tests(2) = dsclass(6);
tests(3) = dsclass(9); tests(4) = dsclass(12);
tests(5) = dsclass(15); tests(6) = dsclass(18);
tests(7) = dsclass(21); tests(8) = dsclass(24);
tests(9) = dsclass(27); tests(10) = dsclass(30);

% load egt.bak
% load egts.bak
% load test.bak
% load tests.bak


P = egt';
T=[egts' (abs(1-egts))'];
Pt = test';

net = newlvq(P,2,[.5 .5],0.008,'learnlv2'); % (P,4,[.5 .5],0.0016,'learnlv3')

net.trainParam.epochs = 25; % 17 10
net = train(net,P,T');

egt_Y = sim(net,P); % Egitim verisi icin

egt_bulunan = egt_Y(1, :)';
sayac = 0;
for i=1:size(egt_bulunan, 1)
   if(egt_bulunan(i) == egts(i)) 
       sayac = sayac + 1;
   end
end
egt_basari1 = sayac/i

egt_bulunan = egt_Y(2, :)';
sayac = 0;
for i=1:size(egt_bulunan, 1)
   if(egt_bulunan(i) == egts(i)) 
       sayac = sayac + 1;
   end
end
egt_basari2 = sayac/i

Y = sim(net,Pt); % Test verisi icin

if egt_basari1 >= egt_basari2
   bulunan = Y(1, :)';
else
   bulunan = Y(2, :)';
end

sayac = 0;
for i=1:size(bulunan, 1)
   if(bulunan(i) == tests(i)) 
       sayac = sayac + 1;
   end
end
basari = sayac/i
