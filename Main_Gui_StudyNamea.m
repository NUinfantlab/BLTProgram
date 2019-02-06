clc;
clear;
Screen('Preference', 'SkipSyncTests', 1);
screenSize = get(0, 'ScreenSize');
width = round(screenSize(3) * 0.9);
height = round(screenSize(4) * 0.85);
y = (screenSize(4) - height)/2;
x = (screenSize(3) - width)/2;
mainWin = figure('Name', 'Habituation Paradigm', ...
    'Position', [x y  width height], ...
    'MenuBar', 'none', 'ToolBar', 'none', 'Color', [0.9 0.9 0.9]);
figure(mainWin);
parentColor = get(mainWin, 'Color');

labelW = (width - 50) / 4;
if (labelW > 280)
    labelW = 280;
end
labelH = floor((height - 70 - 13 * 5)/13);
uiFontSize = 16;

MaxTimeOn = 60; % (seconds) 
LookAway = 2; % (seconds)
MaxSumOfHabTrial = 9; % Max # of Habituation Trial
MinSumOfHabTrial = 6; % Max # of Habituation Trial
MinTimeOn = 2; % (seconds)
StudyName = 'Study Namea';

%right side input
y = height - 65;
left = round(width/2)+10;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Max Time On (sec) (*)', ...
    'Position', [left y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
maxTimeOnInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [labelW+10+left y+10 labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', num2str(MaxTimeOn), ...
                 'FontSize', uiFontSize);

y = y - labelH - 5;
left = round(width/2)+10;
inputLeft = labelW+10+left;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Min Time On (sec) (*)', ...
    'Position', [left y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
minTimeOnInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [inputLeft y+10 labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', num2str(MinTimeOn), ...
                 'FontSize', uiFontSize);

y = y - labelH - 5;
left = round(width/2)+10;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Look Away (sec) (*)', ...
    'Position', [left y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
lookAwayInput = uicontrol(...
                'Parent', mainWin, ...
                'Style', 'edit', ...
                'Position', [inputLeft y+10 labelW labelH], ...
                'backgroundcolor', parentColor, ...
                'String', num2str(LookAway), ...
                'FontSize', uiFontSize);

y = y - labelH - 5;
left = round(width/2)+10;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Min # of Hab. Trial (*)', ...
    'Position', [left y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
minHabTrialInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [inputLeft y+10 labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', num2str(MinSumOfHabTrial), ...
                 'FontSize', uiFontSize);

y = y - labelH - 5;
left = round(width/2)+10;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Max # of Hab. Trial (*)', ...
    'Position', [left y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
maxHabTrialInput = uicontrol(...
                   'Parent', mainWin, ...
                   'Style', 'edit', ...
                   'Position', [inputLeft y+10 labelW labelH], ...
                   'backgroundcolor', parentColor, ...
                   'String', num2str(MaxSumOfHabTrial), ...
                   'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Study Name  (*)', ...
          'Position', [left y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
studyNameInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [inputLeft y labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', StudyName, ...
                 'FontSize', uiFontSize);

%end of right side input

y = height - 65;
uicontrol( ...
    'Parent', mainWin, ...
    'Style', 'text', ...
    'String', 'Name (*)', ...
    'Position', [10 y labelW labelH], ...
    'backgroundcolor', parentColor,...
    'HorizontalAlignment','left', ...
    'FontSize', uiFontSize, ...
    'FontUnits', 'pixels');
nameInput = uicontrol(...
            'Parent', mainWin, ...
            'Style', 'edit', ...
            'Position', [labelW+20 y+10 labelW labelH], ...
            'backgroundcolor', parentColor, ...
            'String', '', ...
            'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Subject Number (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
sbjNumberInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [labelW+20 y+10 labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', '', ...
                 'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Gender (*)(F or M)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor,...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
genderInput = uicontrol(...
              'Parent', mainWin, ...
              'Style', 'edit', ...
              'Position', [labelW+20 y+10 labelW labelH], ...
              'backgroundcolor', parentColor, ...
              'String', '', ...
              'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Birthday  (*) (MM/DD/YYYY)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor,...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
birthdayInput = uicontrol(...
                'Parent', mainWin, ...
                'Style', 'edit', ...
                'Position', [labelW+20 y+10 labelW labelH], ...
                'backgroundcolor', parentColor, ...
                'String', '', ...
                'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Age (*) (Month-Days)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor,...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
ageInput = uicontrol(...
                'Parent', mainWin, ...
                'Style', 'edit', ...
                'Position', [labelW+20 y+10 labelW labelH], ...
                'backgroundcolor', parentColor, ...
                'String', '', ...
                'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Experiment Date  (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
expDateInput = uicontrol(...
               'Parent', mainWin, ...
               'Style', 'edit', ...
               'Position', [labelW+20 y+10 labelW labelH], ...
               'backgroundcolor', parentColor, ...
               'String', 'MM/DD/YY HH:mm', ...
               'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Experimenter  (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
experimenterInput = uicontrol(...
                    'Parent', mainWin, ...
                    'Style', 'edit', ...
                    'Position', [labelW+20 y+10 labelW labelH], ...
                    'backgroundcolor', parentColor, ...
                    'String', '', ...
                    'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Primary Coder  (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
coder1Input = uicontrol(...
              'Parent', mainWin, ...
              'Style', 'edit', ...
              'Position', [labelW+20 y+10 labelW labelH], ...
              'backgroundcolor', parentColor, ...
              'String', '', ...
              'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ....
          'String', 'Secondary Coder', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
coder2Input = uicontrol(...
              'Parent', mainWin, ...
              'Style', 'edit', ...
              'Position', [labelW+20 y+10 labelW labelH], ...
              'backgroundcolor', parentColor, ...
              'String', '', ...
              'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', '# of TestEvent Labels (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
numLabels = uicontrol(...
              'Parent', mainWin, ...
              'Style', 'edit', ...
              'Position', [labelW+20 y labelW labelH], ...
              'backgroundcolor', parentColor, ...
              'String', '', ...
              'FontSize', uiFontSize);

y = y - labelH - 5;
uicontrol('Parent', mainWin, ...
          'Style', 'text', ...
          'String', 'Hab. Condition  (*)', ...
          'Position', [10 y labelW labelH], ...
          'backgroundcolor', parentColor, ...
          'HorizontalAlignment','left', ...
          'FontSize', uiFontSize);
conditionInput = uicontrol(...
                 'Parent', mainWin, ...
                 'Style', 'edit', ...
                 'Position', [labelW+20 y labelW labelH], ...
                 'backgroundcolor', parentColor, ...
                 'String', '', ...
                 'FontSize', uiFontSize);

buttonY = y - labelH - 10;
buttonX = (width - (labelW*2 + 10)) /2;
uicontrol('Parent', mainWin, ...
          'Style', 'pushbutton', ...
          'String', 'Start', ...
          'FontSize', uiFontSize, ...
          'Position', [buttonX buttonY labelW labelH], ...
          'callback', @(src,event)Start_Button_Pressed(nameInput, ...
          sbjNumberInput, genderInput, birthdayInput, expDateInput, ...
          experimenterInput, coder1Input, coder2Input, studyNameInput, ...
          conditionInput, numLabels, maxTimeOnInput, ...
          minTimeOnInput, lookAwayInput, minHabTrialInput, maxHabTrialInput, 0, ageInput));
buttonX = buttonX + labelW + 10;
uicontrol('Parent', mainWin', ...
          'Style', 'pushbutton', ...
          'String', 'Close', ...
          'FontSize', uiFontSize, ...
          'Position', [buttonX buttonY labelW labelH], ...
          'callback', @(src,event)Close_Button_Pressed(src,event, mainWin));
