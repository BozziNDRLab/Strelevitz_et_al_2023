function ageSet = get_sorted_age_set(ageData, speciesFlag)
%  to get a sorted set of all ages that we have in the dataset.
%   ageData: vector that contains all possible ages that we have in the
%   dataset.
%   speciesFlag: can be either "human" or "NHP"
if strcmp(speciesFlag, 'human')
    ageSet_pcw = unique(ageData(contains(ageData,'pcw')),...
        'sorted');
    ageSet_yrs = unique(ageData(contains(ageData,'yrs')),...
        'sorted');
    [~, sorted_pcw_AgeIdx] = sort(extract_num_from_str(ageSet_pcw));
    [~, sorted_yrs_AgeIdx] = sort(extract_num_from_str(ageSet_yrs));
    ageSet = [ageSet_pcw(sorted_pcw_AgeIdx); ageSet_yrs(sorted_yrs_AgeIdx)];
elseif strcmp(speciesFlag, 'NHP')
    ageSet = unique(ageData, 'stable');
else
    error('speciesFlag is not valid, can be either "human" or "NHP"')
end