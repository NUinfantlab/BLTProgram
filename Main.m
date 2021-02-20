try
    commandwindow;
    clc;
    Screen('Preference', 'SkipSyncTests', 1);
    InitializePsychSound(1);
    soundHandle = PsychPortAudio('Open', -1);
    error_sound(1,:) = 0.3 * MakeBeep(1400, 0.05, 44100);
    error_sound(2,:) = error_sound(1,:);
    PsychPortAudio('FillBuffer', soundHandle, error_sound);
    KbName('UnifyKeyNames')
    Exp_Response_Key;

    if (~exist('expDate', 'var') || ~exist('name', 'var') || ...
            ~exist('sbjNumber', 'var') || ~exist('birthday', 'var') || ~exist('age', 'var') || ...
            ~exist('gender', 'var') || ~exist('studyName', 'var') || ...
            ~exist('experimenter', 'var') || ~exist('coder1', 'var') || ...
            ~exist('sbjNumber', 'var') || ~exist('birthday', 'var') || ...
            ~exist('MaxHabTimeOn', 'var') || ~exist('LookAwayHab', 'var') || ...
            ~exist('MaxSumOfHabTrial', 'var') || ~exist('MinHabTimeOn', 'var') || ...
            ~exist('MinSumOfHabTrial', 'var') || ~exist('coder1ResponseKey', 'var') || ...
            ~exist('coder2ResponseKey', 'var') || ~exist('eventLabels', 'var') || ...
            ~exist('MaxTestTimeOn', 'var') || ~exist('MinTestTimeOn', 'var') || ...
            ~exist('MaxSumOfTestTrial', 'var') || ~exist('LookAwayTest', 'var'))
        uiwait(msgbox('Missing Parameters!','Warning','modal'));
        return;
    end
    
    studyName = strrep(studyName, ' ', '_');
    Dir = ['Data/' studyName];
    if (~exist(Dir, 'dir'))
        mkdir(Dir);
    end
    
    fileName = [Dir '/' sbjNumber '_' name '.xls'];
    if (exist(fileName,'file'))
        i=2;
        fileName = [Dir '/' sbjNumber '_' name '_' int2str(i) '.xls'];
        while (exist(fileName,'file'))
            i=i+1;
            fileName = [Dir '/' sbjNumber '_' name '_' int2str(i) '.xls'];
        end
    end
    htmlFileName = strrep(fileName, '.xls', '.html');

    fid=fopen(fileName,'w+');
    StartString = datestr(now);
    fprintf(fid, 'Start: %s\n', StartString);
    fprintf(fid, 'Today: %s\n', expDate);
    fprintf(fid, 'Subject Name: %s   ', name);
    fprintf(fid, 'Subject Number: %s   ', sbjNumber);
    fprintf(fid, 'Birthday: %s   ', birthday);
    fprintf(fid, 'Age: %s   ', age);
    fprintf(fid, 'Subject Sex: %s\n', gender);
    fprintf(fid, 'Experiment: %s   ', studyName);
    fprintf(fid, 'Presenter: %s   ', experimenter);
    fprintf(fid, 'Primary Coder: %s   ', coder1);
    fprintf(fid, 'Secondary Coder: %s\n', coder2);
    fprintf(fid, 'Habituation Condition: %s   ', condition);
    for i = 1:numel(eventLabels)
        fprintf(fid, 'Test %d: %s   ', i, eventLabels{i});
    end
    fprintf(fid, 'MaxHabTimeOn(sec)) = %.2f   ', MaxHabTimeOn);
    fprintf(fid, 'MaxLookAwayHab(sec) = %.2f   ', LookAwayHab);
    fprintf(fid, 'MinHabTimeOn(sec) = %.2f   ', MinHabTimeOn);
    fprintf(fid, 'Max#HabTrials = %d   ', MaxSumOfHabTrial);
    fprintf(fid, 'MaxTestTimeOn(sec)) = %.2f   ', MaxTestTimeOn);
    fprintf(fid, 'MaxLookAwayTest(sec) = %.2f   ', LookAwayTest);
    fprintf(fid, 'MinTestTimeOn(sec) = %.2f   ', MinTestTimeOn);
    fprintf(fid, 'Max#TestTrials = %d   ', MaxSumOfTestTrial);
    fprintf(fid, 'FixedHabituationTime = %d\n\n', fixedHabituationTime);

    htmlFid = fopen(htmlFileName, 'w+');
    fprintf(htmlFid, '<body style="font-size:26px;line-height:1.5"><p><b>Start:</b> %s&nbsp;&nbsp;&nbsp;&nbsp;', StartString);
    fprintf(htmlFid, '<b>Today</b>: %s<br/>', expDate);
    fprintf(htmlFid, '<b>Subject Name:</b> %s&nbsp;&nbsp;&nbsp;&nbsp;', name);
    fprintf(htmlFid, '<b>Subject Number:</b> %s&nbsp;&nbsp;&nbsp;&nbsp;<br/>', sbjNumber);
    fprintf(htmlFid, '<b>Birthday:</b> %s&nbsp;&nbsp;&nbsp;&nbsp;', birthday);
    fprintf(htmlFid, '<b>Age:</b> %s&nbsp;&nbsp;&nbsp;&nbsp;', age);
    fprintf(htmlFid, '<b>Subject Sex:</b> %s<br/>', gender);
    fprintf(htmlFid, '<b>Experiment:</b> %s&nbsp;&nbsp;&nbsp;', studyName);
    fprintf(htmlFid, '<b>Presenter:</b> %s&nbsp;&nbsp;&nbsp;', experimenter);
    fprintf(htmlFid, '<b>Primary Coder:</b> %s&nbsp;&nbsp;&nbsp;', coder1);
    fprintf(htmlFid, '<b>Secondary Coder:</b> %s<br/>', coder2);
    fprintf(htmlFid, '<b>Habituation Condition:</b> %s&nbsp;&nbsp;&nbsp;', condition);
    for i = 1:numel(eventLabels)
        fprintf(htmlFid, '<b>Test %d:</b> %s&nbsp;&nbsp;&nbsp;', i, eventLabels{i});
    end
    fprintf(htmlFid, '<b>MaxHabTimeOn(sec)) =</b> %.2f&nbsp;&nbsp;&nbsp;', MaxHabTimeOn);
    fprintf(htmlFid, '<b>MaxLookAwayHab(sec) =</b> %.2f&nbsp;&nbsp;&nbsp;', LookAwayHab);
    fprintf(htmlFid, '<b>MinHabTimeOn(sec) =</b> %.2f&nbsp;&nbsp;&nbsp;', MinHabTimeOn);
    fprintf(htmlFid, '<b>Max#HabTrials =</b> %d&nbsp;&nbsp;&nbsp;', MaxSumOfHabTrial);
    fprintf(htmlFid, '<b>MaxTestTimeOn(sec)) =</b> %.2f&nbsp;&nbsp;&nbsp;', MaxTestTimeOn);
    fprintf(htmlFid, '<b>MaxLookAwayTest(sec) =</b> %.2f&nbsp;&nbsp;&nbsp;', LookAwayTest);
    fprintf(htmlFid, '<b>MinTestTimeOn(sec) =</b> %.2f&nbsp;&nbsp;&nbsp;', MinTestTimeOn);
    fprintf(htmlFid, '<b>Max#TestTrials =</b> %d&nbsp;&nbsp;&nbsp;', MaxSumOfTestTrial);
    fprintf(htmlFid, '<b>FixedHabituationTime =</b> %d<br/></p>', fixedHabituationTime);

    HideCursor;
    DrawingParameters;
    [win, rect] = Screen('OpenWindow', 0, bgColor);
    Screen('TextStyle', win, textStyle);
    Screen('TextSize', win, textSize);
    
    screenFlipInterval = Screen('GetFlipInterval', win);
    if (fixedHabituation)
        Habituation_Stage_Fixed;
    else
        Habituation_Stage;
    end
    Test_Stage;

    totalData = [habData; testData];
    if (~isempty(totalData))
%         correlation = 0;
        averageAGR = mean(totalData(:,10));
        weight = totalData(:,3) + totalData(:,6);
        weightedAGR = sum(weight .* (totalData(:, 10))) / sum(weight);
        averageSIM = mean(totalData(:, 11));
        averageKappa = Compute_Kappa(totalObserverTime);
    else
%         correlation = 0;
        averageAGR = 0;
        weightedAGR = 0;
        averageSIM = 0;
        averageKappa = 0;
    end
    
    %!!! not sure how to calculate TimeOn correlation.
%     fprintf(fid, 'Primary coder vs Secondary Coder TimeOn Correlation (r) = %.4f\n', correlation);
    fprintf(fid, 'Average Observer %% Agreement = %.2f\n', averageAGR);
    fprintf(fid, 'Weighted Observer %% Agreement = %.2f\n', weightedAGR);
    fprintf(fid, 'Average Observer %% Similarity = %.2f\n', averageSIM);
    fprintf(fid, 'Overall Cohen''s Kappa = %.2f\n\n', averageKappa);
    fprintf(fid, 'End: %s \n\n', datestr(now));

%     fprintf(htmlFid, '<p><b>Primary coder vs Secondary Coder TimeOn Correlation (r) =</b> %.2f<br/>', correlation);
    fprintf(htmlFid, '<span style="font-size:32px"><b>Average Observer %% Agreement =</b> %.2f</span><br/>', averageAGR);
    fprintf(htmlFid, '<b>Weighted Observer %% Agreement =</b> %.2f<br/>', weightedAGR);
    fprintf(htmlFid, '<b>Average Observer %% Similarity =</b> %.2f<br/>', averageSIM);
    fprintf(htmlFid, '<b>Overall Cohen''s Kappa =</b> %.2f<br/></p>', averageKappa);
    fprintf(htmlFid, '<p><b>End: </b>%s </p></body>', datestr(now));

    tsvContent = fileread(fileName);
    
    tsvfid = fopen(strrep(fileName, '.xls', '.tsv'), 'w+');
    fprintf(tsvfid,'%s',tsvContent);
    fclose('all');
    save(strrep(fileName, '.xls', '.mat'));
    
    Screen('CloseAll');
    PsychPortAudio('Close');
    ShowCursor;

    File_Comments_Window(fileName, htmlFileName);
catch exception
    exception
    
    errorDir = 'Data/Error';
    if (~exist(errorDir, 'dir'))
        mkdir(errorDir);
    end
    
    NowTime = clock;
    errorFile = sprintf('%s/%d-%d-%d_%d_%d_%.0f_error.mat', ...
        errorDir, NowTime(1), NowTime(2), NowTime(3), NowTime(4), NowTime(5), NowTime(6));
    save(errorFile);
    
    if (exist('fid', 'var'))
        fprintf(fid,'\nEnd: %s \n\n', datestr(now));
        movefile(fileName, strrep(errorFile, '.mat', '.xls'));

        if (exist('htmlFid', 'var'))
            fprintf(htmlFid,'<p>End: %s </p></body>', datestr(now));
            movefile(htmlFileName, strrep(errorFile, '.mat', '.xls'));
        end
        fclose('all');
    end
    Screen('CloseAll');
    PsychPortAudio('Close');
    ShowCursor;    
end