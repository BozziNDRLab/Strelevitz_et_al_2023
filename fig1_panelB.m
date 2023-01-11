% The following toolbox was used; please first add it to the Matlab search path:
% cbrewer2(https://it.mathworks.com/matlabcentral/fileexchange/58350-cbrewer2)
% Be sure before running the following code to set the working directory as
% the folder where the script is located (by hitting "Run" in the EDITOR
% toolbar tab, Matlab will ask you to do it automatically)
%% load data
clear; clc; close all;
% Set directory of Allen Brain Atlas microarray data for genes of
% interest, for both human and non-human primates (NHP).
% Be sure before running the folowing code to set the working directory as
% the folder containing the scripts.
humanDataDir = 'data\Human\transcriptom';
NHP_dataDir = 'data\NHP';
%---human----
humanData.expresionTable =...
    csvread(fullfile(humanDataDir, 'Expression.csv'));
humanData.expresionData_rowIdx = 2; % the row that contains gen data
humanData.metaData =...
    readtable(fullfile(humanDataDir,'Columns.csv'));
%---NHP---
NHP_Data.expresionTable =...
    csvread(fullfile(NHP_dataDir, 'Expression.csv'));
NHP_Data.expresionData_rowIdx = 5; % the row that contains gen data
NHP_Data.metaData =...
    readtable(fullfile(NHP_dataDir,'Columns.csv'));
%% preprocessing
addpath('functions') %add the functions folder to the Matlab search path 
%---human----
humanData.ageSet =...
    get_sorted_age_set(humanData.metaData.donor_age, 'human');
humanData.structureAbbreviationSet =...
    unique(humanData.metaData.structure_abbreviation, 'stable');
humanData.structureNameSet =...
    unique(humanData.metaData.structure_name, 'stable');
 
%---NHP---
NHP_Data.ageSet =...
    get_sorted_age_set(NHP_Data.metaData.donor_age, 'NHP');
NHP_Data.structureAbbreviationSet =...
    unique(NHP_Data.metaData.structure_abbreviation, 'stable');
NHP_Data.structureNameSet =...
    unique(NHP_Data.metaData.structure_name, 'stable');
%% set print setting and directory
set_nice_plot(12.5, 1.5) %some graphic settings to have a nicer figure
printDirRoot = "C:\master\BDD\eNeuron_paper_test"; %set a directory to print the figures
printDir = fullfile(printDirRoot, 'fig1'); 
if ~exist(printDir, 'dir')
    mkdir(printDir)
end 
%% set Regions of Interest (ROIs)
%---human----
humanData.structureClasses.HPC.name = 'Hippocampal formation';
humanData.structureClasses.HPC.structures = ...
    {'hippocampus (hippocampal formation)'};

humanData.structureClasses.AMG.name = 'Amygdaloid complex';
humanData.structureClasses.AMG.structures = ...
    {'amygdaloid complex'};

humanData.structureClasses.STR.name = 'Striatum';
humanData.structureClasses.STR.structures = ...
    {'striatum'};

humanData.structureClasses.V1.name = 'V1 Cortex';
humanData.structureClasses.V1.structures = ...
    {'primary visual cortex (striate cortex, area V1/17)'};

humanData.structureClasses.other.name = 'Other non-transitory regions';
humanData.structureClasses.other.structures = ...
    {'primary motor cortex (area M1, area 4)';
    'primary somatosensory cortex (area S1, areas 3,1,2)';
    'posteroventral (inferior) parietal cortex';
    'primary auditory cortex (core)';
    'posterior (caudal) superior temporal cortex (area 22c)';
    'inferolateral temporal cortex (area TEv, area 20)'; 
    'dorsal thalamus'; 
    'cerebellar cortex';
    'dorsolateral prefrontal cortex';...
    'ventrolateral prefrontal cortex';...
    'orbital frontal cortex';
    'anterior (rostral) cingulate (medial prefrontal) cortex'};
%% ----NHP ----
NHP_Data.structureClasses.HPC.name = 'Hippocampal formation';
NHP_Data.structureClasses.HPC.structures = ...
    {'granular layer of dentate gyrus (cortex)';
    'subgranular zone of dentate gyrus (cortex)';
    'polyform layer of dentate gyrus (cortex)';
    'stratum radiatum of CA1'; 'stratum pyramidale of CA1';
    'stratum oriens of CA1'; 'stratum pyramidale of CA2';
    'stratum pyramidale of CA3'; 'CA4 region'; 'subiculum'};

NHP_Data.structureClasses.AMG.name = 'Amygdaloid complex';
NHP_Data.structureClasses.AMG.structures = ...
    {'anterior amygdaloid area';
    'central amygdaloid nucleus';
    'rostral periamygdaloid cortex (rPAC)'; 
    'medial nucleus'; 
    'amygdalohippocampal area'; 
    'lateral nucleus'; 
    'basal nucleus (basolateral nucleus)'; 
    'paralaminar nucleus'; 
    'amygdalopiriform transition area'};

NHP_Data.structureClasses.STR.name = 'Striatum';
NHP_Data.structureClasses.STR.structures = ...
    {'caudate nucleus'; 
    'putamen'; 'nucleus accumbens'; 
    'islands of Calleja'; 
    'olfactory tubercle'; 
    'external segment of globus pallidus'; 
    'internal segment of globus pallidus'; 
    'internal capsule'};

NHP_Data.structureClasses.V1.name = 'V1 Cortex';
NHP_Data.structureClasses.V1.structures = ...
    {'layer I of V1'; 
    'layer II of V1'; 
    'layer III of V1'; 
    'layer IVA of V1'; 
    'layer IVB of V1'; 
    'layer IVCa of V1'; 
    'layer IVCb of V1'; 
    'layer V of V1'; 
    'layer VI of V1'};

NHP_Data.structureClasses.other.name = 'Other non-transitory regions';
NHP_Data.structureClasses.other.structures = ...
    {'layer II of V2'; 
    'layer III of V2'; 
    'granular layer IV of V2'; 
    'layer V of V2';     
    'layer VI of V2';
    'layer II of dorsolateral prefrontal cortex'; 
    'layer II of medial orbitofrontal cortex'; 
    'layer II of caudal orbitofrontal cortex'; 
    'layer III of dorsolateral prefrontal cortex'; 
    'layer III of medial orbitofrontal cortex'; 
    'layer III of caudal orbitofrontal cortex'; 
    'granular layer IV of dorsolateral prefrontal cortex'; 
    'granular layer IV of medial orbitofrontal cortex'; 
    'layer V of dorsolateral prefrontal cortex'; 
    'layer V of medial orbitofrontal cortex'; 
    'layer V of caudal orbitofrontal cortex'; 
    'layer VI of dorsolateral prefrontal cortex'; 
    'layer VI of medial orbitofrontal cortex'; 
    'layer VI of caudal orbitofrontal cortex';
    'layer II of rostral cingulate cortex'; 
    'layer VI of rostral cingulate cortex'; 
    'layer V of rostral cingulate cortex'; 
    'layer III of rostral cingulate cortex'};
%% generate heat maps
%---human---
close all;
structureclassesNameList =...
    fieldnames(humanData.structureClasses); 
humanExprationMap = nan(length(structureclassesNameList),...
    length(humanData.ageSet));
humanDonerPerAgePoint =  array2table(zeros(length(structureclassesNameList),...
    length(humanData.ageSet)));
humanDonerPerAgePoint.Properties.VariableNames = humanData.ageSet;
humanDonerPerAgePoint.Properties.RowNames = structureclassesNameList;
for si = 1 : length(structureclassesNameList)
    classSubStructur =...
        humanData.structureClasses.(...
        structureclassesNameList{si}).structures;
    for ai = 1 : length(humanData.ageSet)
        regionExpVec_allDoners = [];
        donerIds = [];
        for ssi = 1 : length(classSubStructur)
            
            subRegionExpVec_allDoners =...
                humanData.expresionTable(...
                humanData.expresionData_rowIdx,...
                strcmp(humanData.metaData.structure_name,...
                classSubStructur{ssi}) &...
                strcmp(humanData.metaData.donor_age,...
                humanData.ageSet{ai}));
             donerIds = [donerIds;...
                 humanData.metaData.donor_id(...
                 strcmp(humanData.metaData.structure_name,...
                 classSubStructur{ssi}) &...
                 strcmp(humanData.metaData.donor_age,...
                 humanData.ageSet{ai}))];

             if ~isempty(subRegionExpVec_allDoners)
                 regionExpVec_allDoners = [regionExpVec_allDoners,...
                     subRegionExpVec_allDoners];
            end    
        end
        if ~isempty(regionExpVec_allDoners)
            humanExprationMap(si,ai) =...
                nanmean(regionExpVec_allDoners);
            humanDonerPerAgePoint{si,ai} =....
                length(unique(donerIds));
        end
        
    end
end

% exclude age points that are not relevant or do not have sufficient expression data
nonRelevantTimePoints =...
    ismember(humanData.ageSet, {'8 pcw' ; '9 pcw' })';
minAvailableDataThreshold = 3;
timePintsWithNotEnoughtData=...
    (sum((cumsum(~isnan(humanExprationMap),2) >= 1).*...
    isnan(humanExprationMap)))>= minAvailableDataThreshold;
timePintToKeep =...
    ~(timePintsWithNotEnoughtData | nonRelevantTimePoints);
humanExprationMap =...
    humanExprationMap(:,timePintToKeep);
humanData.ageSet =...
    humanData.ageSet(timePintToKeep);
% summarize human ages of 30+ years
timePintToAvrageOut = ismember(humanData.ageSet,...
    {'30 yrs' ; '36 yrs'; '37 yrs'; '40 yrs'})';
humanExprationMap =...
    [humanExprationMap(:, 1:find(timePintToAvrageOut,1)-1),...
    nanmean(humanExprationMap(:, timePintToAvrageOut), 2)];
humanData.ageSet =...
    [humanData.ageSet(1:find(timePintToAvrageOut,1)-1); '30+ yrs'];
%% ---NHP---

structureclassesNameList =...
    fieldnames(NHP_Data.structureClasses); 

NHP_exprationMap = nan(length(structureclassesNameList),...
    length(NHP_Data.ageSet));
NHP_DonerPerAgePoint =  array2table(zeros(length(structureclassesNameList),...
    length(NHP_Data.ageSet)));
NHP_DonerPerAgePoint.Properties.VariableNames = NHP_Data.ageSet;
NHP_DonerPerAgePoint.Properties.RowNames = structureclassesNameList;
for si = 1 : length(structureclassesNameList)
    classSubStructur =...
        NHP_Data.structureClasses.(...
        structureclassesNameList{si}).structures;
    for ai = 1 : length(NHP_Data.ageSet)
        regionExpVec_allDoners = [];
        donerIds = [];
        for ssi = 1 : length(NHP_Data.structureClasses.(...
                structureclassesNameList{si}).structures)
            
            subRegionExpVec_allDoners =...
                NHP_Data.expresionTable(...
                NHP_Data.expresionData_rowIdx,...
                strcmp(NHP_Data.metaData.structure_name,...
                classSubStructur{ssi}) &...
                strcmp(NHP_Data.metaData.donor_age,...
                NHP_Data.ageSet{ai}));
             donerIds = [donerIds;...
                 NHP_Data.metaData.donor_id(...
                 strcmp(NHP_Data.metaData.structure_name,...
                 classSubStructur{ssi}) &...
                 strcmp(NHP_Data.metaData.donor_age,...
                 NHP_Data.ageSet{ai}))];

             if ~isempty(subRegionExpVec_allDoners)
                 regionExpVec_allDoners = [regionExpVec_allDoners,...
                     subRegionExpVec_allDoners];
            end    
        end
        if ~isempty(regionExpVec_allDoners)
            NHP_exprationMap(si,ai) =...
                 nanmean(regionExpVec_allDoners);
            NHP_DonerPerAgePoint{si,ai} =....
                length(unique(donerIds));
        end
    end
end
%--- 
%% generate heat maps
cBarLim = [-1.5, 2.15]; % setting color bar limit
colors = cbrewer2('div', 'PiYG', 1500); % geting color map

colorsHuman =...
    colors(unique(fix(unifrnd(751,1500, cBarLim(2)*100, 1))),:); 
    % set colormap for human's heatmap


% adjust bin sizes to have equal X axes for the two species
humanExprationMapForPlot =...
    [humanExprationMap(:,1:7),...
    humanExprationMap(:,7),...
    humanExprationMap(:,8:end)];

figure; % plot the heatmap for human
imAlpha=ones(size(humanExprationMapForPlot));
imAlpha(isnan(humanExprationMapForPlot))=0;
imagesc(humanExprationMapForPlot, 'AlphaData',imAlpha)
cb = colorbar('FontSize', 12 ,'Box', 'off',...
    'Location', 'eastoutside');
colormap(colorsHuman)
caxis([0, cBarLim(2)])
yticks(1:size(humanExprationMapForPlot, 1))
xticks([1:7, 9:21])
xtickangle(45);
ytickangle(45);
xticklabels(humanData.ageSet);
yticklabels(...
    structureclassesNameList);
title('human')
box off
cdInfo = get(cb);
cdInfo =  cdInfo.Position;
set(cb,...
    'Position',[cdInfo(1)+.08 cdInfo(2) 2*cdInfo(3)/3 cdInfo(4)/2],...
    'LineWidth', 1)
set(gca, 'XAxisLocation', 'top')
set(gcf,'Position',[50 50 640 230]);
set(gca,'color',.65*[1 1 1]);
print('-dpng','-r300',...
           fullfile(printDir, 'fig1_panelB_NP.png'));
print('-vector', '-dpdf',...
    fullfile(printDir, 'fig1_panelB_NP.pdf'));

fprintf('Number of donors for each map bin (human): \n')
disp(humanDonerPerAgePoint) % display the number of donors for each map bin
%%  ----- NHP ---
colors_NHP =...
    [colors( unique(fix(unifrnd(1,750, abs(cBarLim(1)*100), 1))),:);...
    colors( unique(fix(unifrnd(751,1500, cBarLim(2)*100, 1))),:)];
    % set colormap for NHP's heatmap

% adjust bin sizes to have equal X axes for the two species
NHP_exprationMapForPlot =...
    [NHP_exprationMap(:, 1:3),...
    NHP_exprationMap(:, 3:4),...
    NHP_exprationMap(:, 4:9),...
    NHP_exprationMap(:, 9),...
    NHP_exprationMap(:, 9),...
    NHP_exprationMap(:, 9:10),...
    NHP_exprationMap(:, 10),...
    NHP_exprationMap(:, 10),...
    NHP_exprationMap(:, 10),...
    nan(size(NHP_exprationMap(:, 1:3)))];

figure; % plot the heatmap for NHP
imAlpha=ones(size(NHP_exprationMapForPlot));
imAlpha(isnan(NHP_exprationMapForPlot))=0;
imagesc(NHP_exprationMapForPlot,'AlphaData',imAlpha)
cb = colorbar('FontSize', 12 , 'Box',...
    'off', 'Location', 'eastoutside');
colormap(colors_NHP)
caxis([-1.5, 2.15])
yticks(1:size(NHP_exprationMapForPlot, 1))
xticks([1,2,3,5,7,8,9,10,11,15])
xtickangle(45);
ytickangle(45);
xticklabels(NHP_Data.ageSet);
yticklabels(...
    structureclassesNameList);
title('non-human primates')
box off
set(gcf,'Position',[50 400 640 200]); 
set(gca,'color',.65*[1 1 1]);
cdInfo = get(cb);
cdInfo =  cdInfo.Position;
set(cb,...
    'Position',[cdInfo(1)+.08 cdInfo(2) 2*cdInfo(3)/3 2*cdInfo(4)/3],...
    'LineWidth', 1)
print('-dpng','-r300',...
           fullfile(printDir, 'fig1_panelB_NHP.png'));
print('-vector', '-dpdf',...
    fullfile(printDir, 'fig1_panelB_NHP.pdf'));

fprintf('Number of donors for each map bin (NHP): \n')
disp(NHP_DonerPerAgePoint)% display the number of donors for each map bin
%%
rmpath('functions')
