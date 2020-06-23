%
% START HABITUATION
%        

fprintf(fid, '\tHAB-Trial\tCOND\tCRIT\tTIMEON\tSECOND TIMEON\tLATENCY\tTIMEOFF\tSECOND TIMEOFF\t#OFF\tSECOND #OFF\t%%AGR\t%%SIM\tKAPPA\n');
fprintf(htmlFid, ...
        ['<table border="1" style="border-collapse:collapse; font-size:24px" width="1400"><tr>' ...
         '<th>HAB-Trial</th><th>COND</th><th>CRIT</th><th>TIMEON</th>' ...
         '<th>SECOND TIMEON</th><th>LATENCY</th><th>TIMEOFF</th>' ...
         '<th>#OFF</th><th>%%AGR</th><th>%%SIM</th><th>KAPPA</th></tr>']);

habData = []; %Trial, criterion, TimeOn, 2nd TimeOn, latency, TimeOff, 2nd TimeOff, # Off, 2nd # Off, AGR, SIM, KAPPA
exitHab = 0;
trial = 0;
criterion = 0;
timeOn = 0;
timeOn2 = 0;
timeOff = 0;
timeOff2 = 0;
lookAway1 = 0;
lookAway2 = 0;
meetCriterion = 0; % 0 = not meet criterion; 1 = meet criterion; 2 = meet criterion
AGR = 0;
SIM = 0;
KAPPA = 0;
observerTime = [0 0; 0 0]; % timeOn of [AB A-; -B --] 
latency = 0;
SN = 0;
totalObserverTime = [0 0; 0 0];
critStartIndex = 0;
critEndIndex = 0;

while (~exitHab)
    if (0 == trial)
        Draw_Hab_Message(win, 'Begin', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
    else
        KAPPA = Compute_Kappa(observerTime);
        AGR = Compute_Agr(observerTime);
        timeOn = min(sum(observerTime(1,:)), MaxTimeOn);
        timeOn2 = min(sum(observerTime(:,1)), MaxTimeOn);
        SIM = Compute_Similarity(timeOn, timeOn2);
        timeOff = sum(observerTime(2,:));
        timeOff2 = sum(observerTime(:,2));

        habData(trial, :) = [trial criterion timeOn timeOn2 latency timeOff timeOff2 lookAway1 lookAway2 AGR SIM KAPPA];
        if (0 == meetCriterion)
            if (trial >= MaxSumOfHabTrial)
                meetCriterion = 1;
                pause(.3);
                SoundAlert;
            else
                if ( (criterion ~= 0) && (trial >= (critEndIndex + 3)) && (trial >= MinSumOfHabTrial))
                    if (sum(habData(trial-2:trial, 3)) < criterion)
                        meetCriterion = 1;
                        pause(.3);
                        SoundAlert;
                    end
                end
            end

            if (meetCriterion == 1)
                Draw_Hab_Message(win, 'MeetCriterion', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
                while (1)
                    [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
                    if (keyCode(KbName('C')))
                        break;
                    elseif (keyCode(KbName('T')))
                        totalObserverTime = totalObserverTime + observerTime;
                        exitHab = 1;
                        format = '%d\tC %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        fprintf(fid, format, ...
                            SN, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);

                        columnBg = '#FFFFFF';
                        if (trial <= 3)
                            columnBg = '#DDDDDD';
                        end
                        format = ['<tr bgcolor="%s"><td>C %d</td><td>%s</td>' ...
                                  '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                  '<td>%.2f</td><td>%.2f</td>' ...
                                  '<td>%d</td><td>%.2f</td>' ...
                                  '<td>%.2f</td><td>%.2f</td></tr>'];
                        fprintf(htmlFid, ...
                                format, ...
                                columnBg, trial, condition, ...
                                criterion, timeOn, timeOn2, ...
                                latency, timeOff, ...
                                lookAway1, AGR, ...
                                SIM, KAPPA);
                        clear format columnBg;
                        break;
                    end
                end
            end

            if (~exitHab)
                Draw_Hab_Message(win, 'ContinueNextTrail', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
            end
        else
            meetCriterion = 2;
            Draw_Hab_Message(win, 'ContinueNextTrail', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
        end
    end

    if (~exitHab)
        while (1)
            [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
            if (keyCode(KbName('Space')))
                if (trial > 0)
                    % record
                    if (meetCriterion > 0)
                        format = '%d\tC %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>C %d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    else
                        format = '%d\t%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>%d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    end

                    columnBg = '#FFFFFF';
                    if (trial <= 3)
                        columnBg = '#DDDDDD';
                    end
                    fprintf(fid, format, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);
                    fprintf(htmlFid, format2, ...
                        columnBg, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, lookAway1, AGR, SIM, KAPPA);
                    clear format format2 columnBg;

                    if (size(habData,1) == 3)
                        critEndIndex = size(habData,1);
                        critStartIndex = critEndIndex - 2;
                        criterion = sum(habData(critStartIndex:critEndIndex, 3))/2;
                    end
                    totalObserverTime = totalObserverTime + observerTime;
                end
                trial = trial + 1;
                break;
            elseif ((trial > 0) && keyCode(KbName('B')))
                if (trial > 0)
                    habData(trial, :) = [];
                    if (meetCriterion == 1)
                        meetCriterion = 0;
                    end

                    if (meetCriterion > 0)
                        format = '%d\tB C %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>B C %d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    else
                        format = '%d\tB %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>B %d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    end

                    columnBg = '#FFFFFF';
                    if (trial <= 3)
                        columnBg = '#DDDDDD';
                    end
                    fprintf(fid, format, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);
                    fprintf(htmlFid, format2, ...
                        columnBg, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, lookAway1, AGR, SIM, KAPPA);
                    clear format format2 columnBg;
                end
                break;
            elseif (keyCode(KbName('T')))
                if (trial > 0)
                    % record
                    if (meetCriterion)
                        format = '%d\tC %d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>C %d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    else
                        format = '%d\t%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n';
                        format2 = ['<tr bgcolor="%s"><td>%d</td><td>%s</td>' ...
                                   '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td>' ...
                                   '<td>%d</td><td>%.2f</td>' ...
                                   '<td>%.2f</td><td>%.2f</td></tr>'];
                    end

                    columnBg = '#FFFFFF';
                    if (trial <= 3)
                        columnBg = '#DDDDDD';
                    end
                    fprintf(fid, format, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);
                    fprintf(htmlFid, format2, ...
                        columnBg, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, lookAway1, AGR, SIM, KAPPA);
                    clear format format2 columnBg;
                    totalObserverTime = totalObserverTime + observerTime;
                end
                exitHab = 1;
                break;
            end            
        end
        SN = SN + 1;
    end
    
    %
    % START TRIAL
    %
    if (~exitHab)
        exitTrial = 0;
        observerTime = [0 0; 0 0];
        preResponse = 2; %1: looking, 2:lookAway;
        preResponse2 = 2;
        startRecording = 0;
        lookAway1 = 0;
        lookAway2 = 0;
        lookAwayStartTime = 0;
        latency = 0;
        status = 'BeginTrial'; % 'BeginTrial' | 'LookTooShort' | 'FirstLookRecorded'
        errorResponse = 0;
        errorRespTime = 0;

        Draw_Hab_Message(win, 'BeginTrial', trial, criterion, timeOn, meetCriterion, condition, 4, 0);
        trialStart = GetSecs;
        while (1)
            [keyIsDown, Secs, keyCode, deltaSecs] = KbCheck(-1);
            coder1Response = 2 - keyCode(coder1ResponseKey);
            coder2Response = 2 - keyCode(coder2ResponseKey);
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
            responseStatus = coder1Response + (coder2Response - 1) * 2;

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

            Draw_Hab_Message(win, status, trial, criterion, timeOn, meetCriterion, condition, responseStatus, sum(sum(observerTime)));
            preResponse = coder1Response;
            preResponse2 = coder2Response;
        end
    end
    %
    % END TRIAL
    %
end

if ~isempty(habData)
    if (size(habData,1) == 1)
        sumData = habData;
        meanData = habData;
    else
        sumData = sum(habData);
        meanData = mean(habData);
    end
    fprintf(fid, '\tTOTAL\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n', ...
        condition, criterion, sumData(3), sumData(4), sumData(5), ...
        sumData(6), sumData(7), sumData(8), sumData(9));
    fprintf(fid, '\tMEAN\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n\n', ...
        condition, criterion, meanData(3), meanData(4), meanData(5), ...
        meanData(6), meanData(7), meanData(8), meanData(9));

    fprintf(htmlFid, ...
        ['<tr><td>TOTAL</td><td>%s</td><td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td></td><td></td><td></td></tr>'], ...
        condition, criterion, sumData(3), sumData(4), sumData(5), ...
        sumData(6), sumData(8));
    fprintf(htmlFid, ...
        ['<tr><td>MEAN</td><td>%s</td><td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td></td><td></td><td></td></tr></table><br/>'], ...
        condition, criterion, meanData(3), meanData(4), meanData(5), ...
        meanData(6), meanData(8));
else
    fprintf(fid, '\n');
    fprintf(htmlFid, '</table><br/>');
end

%
% END HABITUATION
%
