function numVec = extract_num_from_str(strCell)
% extracting all digit number of a string
% adoupted from https://it.mathworks.com/matlabcentral/answers/44049-extract-numbers-from-mixed-string
numVec = [];
for i = 1 : length(strCell)
    str = strCell{i};
    str1 = regexprep(str,'[,;=]', ' ');
    str2 = regexprep(regexprep(str1,'[^- 0-9.eE(,)/]',''), ' \D* ',' ');
    str3 = regexprep(str2, {'\.\s','\E\s','\e\s','\s\E','\s\e'},' ');
    numVec = [numVec; str2num(str3)];
end