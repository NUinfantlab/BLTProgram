%
% Start TEST
%
fprintf(fid, '\tTEST-Trial\tCOND\tTIMEON\tSECOND TIMEON\tLATENCY\tTIMEOFF\tSECOND TIMEOFF\t#OFF\tSECOND #OFF\t%%AGR\t%%SIM\tKAPPA\n');
fprintf(htmlFid, ...
        ['<table border="1" style="border-collapse:collapse; font-size:24px" width="1400"><tr>' ...
         '<th>TEST-Trial</th><th>COND</th><th>TIMEON</th>' ...
         '<th>SECOND TIMEON</th><th>LATENCY</th><th>TIMEOFF</th>' ...
         '<th>#OFF</th>' ...
         '<th>%%AGR</th><th>%%SIM</th><th>KAPPA</th></tr>']);

testData = []; %Trial, Test1 or Test 2, TimeOn, 2nd TimeOn, latency, TimeOff, 2nd TimeOff, # Off, 2nd # Off, AGR, SIM, KAPPA
exitTest = 0;
trial = 0;
timeOn = 0;
timeOn2 = 0;
timeOff = 0;
timeOff2 = 0;
lookAway1 = 0;
lookAway2 = 0;
testIndex = 1; %`: display Test1; 2: display Test2 
numberOfLabels = numel(eventLabels);
preTestIndex = numberOfLabels;
preTestEvent = eventLabels{1};
AGR = 0;
SIM = 0;
KAPPA = 0;
observerTime = [0 0; 0 0]; % timeOn of [AB A-; -B --] 
latency = 0;
SN = 0;

while (~exitTest)
    % Set the event label based on the index, which will increment
    % Starts identical to preTestEvent, then is always one past it
    %In particular, this updates to reflect changes from the ending thing
    testEvent = eventLabels{testIndex};

    if (0 == trial)
        Draw_Test_Message(win, 'Begin', testEvent, trial, timeOn, SN);
    else
        KAPPA = Compute_Kappa(observerTime);
        AGR = Compute_Agr(observerTime);
        timeOn = sum(observerTime(1,:));
        timeOn2 = sum(observerTime(:,1));
        SIM = Compute_Similarity(timeOn, timeOn2);
        timeOff = sum(observerTime(2,:));
        timeOff2 = sum(observerTime(:,2));
        
        testData(trial, :) = [trial preTestIndex timeOn timeOn2 latency timeOff timeOff2 lookAway1 lookAway2 AGR SIM KAPPA];
        Draw_Test_Message(win, 'ContinueNextTrail', testEvent, trial, timeOn, SN);
    end

    while (1)
        [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
        if (keyCode(KbName('Space')))
            if (trial > 0)
                format = '%d\t%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                fprintf(fid, format, ...
                    SN, trial, preTestEvent, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);

                columnBg = '#FFFFFF';
                if (mod(preTestIndex, 2))
                    columnBg = '#DDDDDD';
                end
                format = ['<tr bgcolor="%s"><td>%d</td><td>%s</td>' ...
                          '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td><td>%d</td>' ...
                          '<td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td></tr>'];
                fprintf(htmlFid, format, ...
                        columnBg, trial, preTestEvent, ...
                        timeOn, timeOn2, latency, ...
                        timeOff, lookAway1, ...
                        AGR, SIM, ...
                        KAPPA);
                clear format columnBg;
            end
            trial = trial + 1;
            break;
        elseif ((trial > 0) && keyCode(KbName('B')) )
            if (trial > 0)
                testData(trial, :) = [];
                format = '%d\tB %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                fprintf(fid, format, ...
                    SN, trial, preTestEvent, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);

                columnBg = '#FFFFFF';
                if (mod(preTestIndex, 2))
                    columnBg = '#DDDDDD';
                end

                format = ['<tr bgcolor="%s"><td>B %d</td><td>%s</td>' ...
                          '<td>%.2f</td><td>%.2f</td><td>%.2f</td>'...
                          '<td>%.2f</td><td>%d</td>'...
                          '<td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td></tr>'];
                fprintf(htmlFid, ...
                        format, ...
                        columnBg, trial, preTestEvent, ...
                        timeOn, timeOn2, latency, ...
                        timeOff, lookAway1, ...
                        AGR, SIM, ...
                        KAPPA);
                clear format columnBg;
                totalObserverTime = totalObserverTime + observerTime;
            end

            % show message & change testEvent if needed
            preTestEvent = eventLabels{preTestIndex};

            Draw_Test_Message(win, 'BadTrial', preTestEvent, trial, timeOn, SN);
            while (1)
                [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
                if ( keyCode(KbName('C')) )
                    break;
                elseif ( keyCode(KbName('R')) )
                    % Test index reverts back one step
                    testEvent = eventLabels{preTestIndex};
                    testIndex = preTestIndex;
                    break;
                end                    
            end
            break;
        elseif ( keyCode(KbName('S')) )
            if (trial > 0)
                format = '%d\t%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                fprintf(fid, format, ...
                    SN, trial, preTestEvent, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);

                columnBg = '#FFFFFF';
                if (mod(preTestIndex, 2))
                    columnBg = '#DDDDDD';
                end
                format = ['<tr bgcolor="%s"><td>%d</td><td>%s</td>' ...
                          '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td><td>%d</td>' ...
                          '<td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>'];
                fprintf(htmlFid, ...
                        format, ...
                        columnBg, trial, preTestEvent, ...
                        timeOn, timeOn2, latency, ...
                        timeOff, lookAway1, ...
                        AGR, SIM, KAPPA);

                clear format columnBg;
                totalObserverTime = totalObserverTime + observerTime;
            end
            exitTest = 1;
            break;
        end
    end
    SN = SN + 1;
    %
    % START TRIAL
    %
    if (~exitTest)
        exitTrial = 0;
        observerTime = [0 0; 0 0];
        preResponse = 2; %1: looking, 2:lookAway;
        preResponse2 = 2;
        startRecording = 0;
        lookAway1 = 0;
        lookAway2 = 0;
        lookAwayStartTime = 0;
        latency = 0;
        status = 'BeginTrial';
        errorResponse = 0;
        errorRespTime = 0;


        Draw_Test_Message(win, 'BeginTrial', testEvent, trial, timeOn, SN, 4, 0);
        
        trialStart = GetSecs;
        
        while (1)
            [keyIsDown, Secs, keyCode, deltaSecs] = KbCheck(-1);
            coder1Response = 2 - keyCode(coder1ResponseKey);
            coder2Response = 2 - keyCode(coder2ResponseKey);
            responseStatus = coder1Response + (coder2Response - 1) * 2;

            errorKeyCode = keyCode;
            errorKeyCode([coder1ResponseKey coder2ResponseKey]) = [];
            if (~isempty(find(errorKeyCode==1, 1)))
                errorResponse = 0;
                errorRespTime = errorRespTime + deltaSecs;
                if (errorRespTime >= 1)
                    PsychPortAudio('Start', soundHandle, 1, inf, 0);
                    PsychPortAudio('RescheduleStart', soundHandle, 0, 0);
                    PsychPortAudio('Stop', soundHandle, 1);
                    errorRespTime = 0;
                end
            else
                errorResponse = 1;
                errorRespTime = 0;
            end
            if (startRecording)
                observerTime(preResponse , preResponse2 ) = ...
                    observerTime(preResponse, preResponse2) + deltaSecs;
                if ((preResponse == 1) && (coder1Response == 2))
                    lookAway1 = lookAway1 + 1;
                end
                if ((preResponse2 == 1) && (coder2Response == 2))
                    lookAway2 = lookAway2 + 1;
                end

                if (sum(observerTime(1,:)) >= MaxTimeOn)
                    SoundAlert;
                    break;
                end
            end

            if ((preResponse == 1) && (coder1Response == 2))
                lookAwayStartTime = Secs;
            elseif ((preResponse == 2) && (coder1Response == 1))
                if (~startRecording)
                    latency = Secs - trialStart;
                    startRecording = 1;
                    status = 'FirstLookRecorded';
                end
            elseif ((preResponse == 2) && (coder1Response == 2))
                if (startRecording && (Secs - lookAwayStartTime) >= LookAway)
                    if (sum(observerTime(1,:)) < MinTimeOn)
                        observerTime = [0 0; 0 0];
                        startRecording = 0;
                        lookAway1 = 0;
                        lookAway2 = 0;
                        status = 'LookTooShort';
                    else
                        SoundAlert;
                        break;
                    end
                end
            end

            Draw_Test_Message(win, status, testEvent, trial, timeOn, SN, responseStatus, sum(sum(observerTime)));
            preResponse = coder1Response;
            preResponse2 = coder2Response;
        end
    end
    %
    % END TRIAL
    %
    preTestIndex = testIndex;
    preTestEvent = testEvent;
    testIndex = testIndex + 1;
    if(testIndex > numberOfLabels) testIndex = 1; end
end
%
% END TEST
%
if ~isempty(testData)
    for i = 1:numberOfLabels
        index = find(testData(:, 2)==i);
        if ~isempty(index)
            if (length(index) == 1)
                sumData = testData(index, :);
                meanData = testData(index, :);
            else
                sumData = sum(testData(index, :));
                meanData = mean(testData(index, :));
            end
            testEvent = eventLabels{i};
            fprintf(fid, '\tTOTAL\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\n', ...
                testEvent, sumData(3), sumData(4), sumData(5), sumData(6), ...
                sumData(7), sumData(8), sumData(9));
            fprintf(fid, '\tMEAN\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n', ...
                testEvent, meanData(3), meanData(4), meanData(5), meanData(6), ...
                meanData(7), meanData(8), meanData(9));

            fprintf(htmlFid, ...
                ['<tr bgcolor="#DDDDDD"><td>TOTAL</td><td>%s</td><td>%.2f</td><td>%.2f</td>' ...
                '<td>%.2f</td><td>%.2f</td><td>%d</td>' ...
                '<td></td><td></td><td></td></tr>'], ...
                testEvent, sumData(3), sumData(4), sumData(5), sumData(6), ...
                sumData(8));
            fprintf(htmlFid, ...
                ['<tr bgcolor="#DDDDDD"><td>MEAN</td><td>%s</td><td>%.2f</td><td>%.2f</td>' ...
                '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                '<td></td><td></td><td></td></tr>'], ...
                testEvent, meanData(3), meanData(4), meanData(5), meanData(6), ...
                meanData(8));
        end
    end
    fprintf(fid, '\n');
    fprintf(htmlFid, '</table>');
else
    fprintf(fid, '\n');
    fprintf(htmlFid, '</table>');
end
