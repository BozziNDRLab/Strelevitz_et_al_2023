function set_nice_plot(fontSize, AxesLineWidth)

if exist('fontSize','var')==0 || isempty(fontSize)
    fontSize=12.5; 
end
if exist('AxesLineWidth','var')==0 || isempty(AxesLineWidth)
    AxesLineWidth=1.5; 
end
%%
set(groot, 'DefaultAxesTickDir', 'out');
set(groot, 'DefaultAxesTickDirMode', 'manual');
% general graphics, this will apply to any figure you open (groot is the default figure object).
% I have this in my startup.m file, so I don't have to retype these things whenever plotting a new fig.
set(groot, ...
    'DefaultFigureColor', 'w', ...
    'DefaultAxesLineWidth', AxesLineWidth, ...
    'DefaultAxesXColor', 'k', ...
    'DefaultAxesYColor', 'k', ...
    'DefaultAxesFontUnits', 'points', ...
    'DefaultAxesFontSize', fontSize, ...
    'DefaultAxesFontName', 'Helvetica', ...
    'DefaultLineLineWidth', AxesLineWidth, ...
    'DefaultTextFontUnits', 'Points', ...
    'DefaultTextFontSize', fontSize, ...
    'DefaultTextFontName', 'Helvetica', ...
    'DefaultAxesBox', 'off', ...
    'DefaultAxesTickLength', [0.02 0.025],...
    'DefaultAxesFontWeight','bold',...
    'DefaultTextFontWeight','bold');


