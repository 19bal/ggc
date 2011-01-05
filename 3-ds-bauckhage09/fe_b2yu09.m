function seg = fe_b2yu09(dist, R, C, dbg)
% function seg = fe_b2yu09(dist, R, C, dbg)
% 
% Ilgili makaleler
% 
% 1. bauckhage09
% 2. yu09
% 3. jang05

% % dist'in son elemani "global normalizasyon faktoru-centroid:y/H"
% gn = dist(end);
% dist = dist(1:end-1)';

%% A) [jang05] nin segmenlari
% segmen y-koordinat degerleri
H = R;
y_chest = round(H - 0.870 * H) + 1;
y_waist = round(H - 0.530 * H) + 1;
y_legs  = round(H - 0.285 * H) + 1;

% 1-head
s = [];
% % IV
h = y_chest - 2;
s = [s dist(end + 1 - (h:-1:1))];

% % I
s = [s dist(1:C)];

% % II
s = [s dist(C + (1:h))];

seg.head = s;

% 2-chest
seg.chest = dist(end - ((y_waist-y_chest-1):-1:(y_chest - 2)));

% 3-back
seg.back = dist(C + ((y_chest - 1):(y_waist - y_chest)));

% 4-waist
h = y_legs - y_waist;
s = [];
% % IV
s = [s dist(end - 2 - (h:-1:1))];
% % II
s = [s dist(C + y_waist - 2 + (1:h))];
seg.waist = s;

% 5-legs
seg.legs = dist((C + y_waist - 2 + h + 1):(end - 2 - h - 1));

%% B) sirali ozdegerler 
% [jang05] in skorlari
score = [4.71 3.93 2.07 1.86 2.57];
N = length(struct2array(seg));
nos = round(N * score / sum(score));

snm = fieldnames(seg);

userpath('clear');      % resample @dipimage ile cakisiyor.
sz = length(snm);
for i=1:sz
    t = getfield(seg, char(snm(i)));
    t2 = resample(t, nos(i), length(t));
    seg = setfield(seg, char(snm(i)), t2);
end












% [yu09]
% 1       .  .  .       C
% +-----------------------+ 1
% |           1           |
% +-----------+-----------+
% |  2        |      3    | .
% +-----------+-----------+ .
% |           4           | .
% +-----------------------+
% |           5           |
% +-----------------------+ R


% [bauckhage09]
% 1       .  .  .       C
% +---------------------+ 1
% |          I          | 
% +----+-----------+----+ 
% |    |           |    | .
% |    |           |    |
% | IV |           | II | .
% |    |           |    |
% |    |           |    | .
% +----+-----------+    |
% |        III     |    |
% +----------------+----+ R
