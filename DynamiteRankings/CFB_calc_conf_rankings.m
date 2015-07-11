function CFB_calc_conf_rankings(year, week)
%
addpath ../Base

%% === Read overall rankings ===
rankFile = sprintf('OverallRankings-%s-%s.cfb', year, week);
ranks = csvread(rankFile);
conferences = cell(11, 2);

%% === ACC ===
iACC = [15; 51; 97; 70; 30; 21; 121; 35; 84; 24; 119; 69; 120; 56];
conferences{1,2} = -1 * mean(ranks(iACC,4));
conferences{1,1} = 'ACC';

%% === American ===
iAmerican = [108; 20; 99; 55; 25; 112; 93; 37; 110; 88; 107];
conferences{2,2} = -1 * mean(ranks(iAmerican,4));
conferences{2,1} = 'American';

%% === B1G ===
iB1G = [59; 58; 87; 40; 83; 53; 76; 61; 39; 41; 65; 85; 73; 127];
conferences{3,2} = -1 * mean(ranks(iB1G,4));
conferences{3,1} = 'B1G';

%% === Big 12 ===
iBig12 = [43; 13; 44; 98; 77; 124; 104; 101; 78; 42];
conferences{4,2} = -1 * mean(ranks(iBig12,4));
conferences{4,1} = 'Big 12';

%% === Conference USA ===
iCUSA = [125; 52; 79; 109; 60; 28; 27; 115; 114; 86; 50; 95; 71];
conferences{5,2} = -1 * mean(ranks(iCUSA,4));
conferences{5,1} = 'Conference USA';

%% === Independent ===
iInd = [11; 74; 9; 64];
conferences{6,2} = -1 * mean(ranks(iInd,4));
conferences{6,1} = 'Independent';

%% === MAC ===
iMAC = [75; 2; 17; 16; 54; 57; 45; 19; 72; 12; 126; 26; 105];
conferences{7,2} = -1 * mean(ranks(iMAC,4));
conferences{7,1} = 'MAC';

%% === Mountain West ===
iMW = [90; 66; 89; 113; 31; 36; 23; 1; 128; 67; 117; 14];
conferences{8,2} = -1 * mean(ranks(iMW,4));
conferences{8,1} = 'Mountain West';

%% === Pac-12 ===
iPac12 = [123; 18; 82; 96; 81; 122; 6; 5; 116; 111; 22; 94];
conferences{9,2} = -1 * mean(ranks(iPac12,4));
conferences{9,1} = 'Pac-12';

%% === SEC ===
iSEC = [29; 46; 118; 63; 32; 100; 92; 10; 102; 3; 80; 47; 62; 7];
conferences{10,2} = -1 * mean(ranks(iSEC,4));
conferences{10,1} = 'SEC';

%% === Sun Belt ===
iSB = [91; 38; 8; 34; 48; 49; 68; 103; 4; 33; 106];
conferences{11,2} = -1 * mean(ranks(iSB,4));
conferences{11,1} = 'Sun Belt';

%% === Sort and print ===
conferences = sortrows_octave(conferences, 2);
cRanks = '';
for iConf = 1:11
    cRanks = sprintf('%s%s,%.2f\n', cRanks, conferences{iConf,1}, -1*conferences{iConf,2});
end
fprintf('%s', cRanks);
file = sprintf('ConferenceRankings-%s-%s.cfb', year, week);
fid = fopen(file, 'w');
fprintf(fid, '%s', cRanks);
fclose(fid);

%%
end

%%
function sCell = sortrows_octave(cell, iCol)
%%

nRows = size(cell, 1);
nCols = size(cell, 2);
data = zeros(nRows, 1);
for iRow = 1:nRows
    data(iRow,1) = cell{iRow, iCol};
end
[~, iData] = sort(data);

sCell = cell(nRows, nCols);
for iRow = 1:nRows
    thisRow = iData(iRow);
    for jCol = 1:nCols
        sCell{iRow,jCol} = cell{thisRow,jCol};
    end
end

end
