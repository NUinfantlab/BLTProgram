%
% START HABITUATION
%        

fixedHabituationTsvHeaders = '';
fixedHabituationHtmlHeaders = '';
if (fixedHabituation)
    fixedHabituationTsvHeaders = 'Fixed-TIMEON\t';
    fixedHabituationHtmlHeaders = '<th>Fixed-TIMEON</th>';
end
fprintf(fid, ['\t', fixedHabituationTsvHeaders, ...
    'HAB-Trial\tCOND\tCRIT\tTIMEON\tSECOND TIMEON\t', ...
    'LATENCY\tTIMEOFF\tSECOND TIMEOFF\t#OFF\tSECOND #OFF\t%%AGR\t%%SIM\tKAPPA\n']);
fprintf(htmlFid, ...
        ['<table border="1" style="border-collapse:collapse; font-size:24px" width="1400"><tr>', ...
         fixedHabituationHtmlHeaders, '<th>HAB-Trial</th><th>COND</th><th>CRIT</th><th>TIMEON</th>' ...
         '<th>SECOND TIMEON</th><th>LATENCY</th><th>TIMEOFF</th>' ...
         '<th>#OFF</th><th>%%AGR</th></tr>']);

habData = []; %OPTIONAL:Fixed-Trial, OPTIONAL:Fixed-TIMEON, Trial, criterion, TimeOn, 2nd TimeOn, latency, TimeOff, 2nd TimeOff, # Off, 2nd # Off, AGR, SIM, KAPPA
exitHab = 0;
trial = 0;
criterion = 0;
timeOn = 0;
timeOn2 = 0;
timeOff = 0;
timeOff2 = 0;
lookAway1 = 0;
lookAway2 = 0;
totalTime = 0;
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
% begin, or run between-trial checks
    if (0 == trial)
        Draw_Hab_Message(win, 'Begin', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
    else
    % if we've moved on past the first trial, calculate times
        KAPPA = Compute_Kappa(observerTime);
        if (isnan(KAPPA))
            KAPPA = 0;
        end
        AGR = Compute_Agr(observerTime);
        % NaN means no looking from either observer
        % they 100% agree no looking
        if (isnan(AGR))
            AGR = 1;
        end
        timeOn = min(sum(observerTime(1,:)), MaxHabTimeOn);
        timeOn2 = min(sum(observerTime(:,1)), MaxHabTimeOn);
        SIM = Compute_Similarity(timeOn, timeOn2);
        timeOff = sum(observerTime(2,:));
        timeOff2 = sum(observerTime(:,2));

        % add a new row of data to the matrix
        habData(trial, :) = [trial criterion timeOn timeOn2 latency timeOff timeOff2 lookAway1 lookAway2 AGR SIM KAPPA];
        % if we have not met the criterion
        if (0 == meetCriterion)
            % Check if we've done the max number of trials.
            % If we've already done max trials, end hab
            if (trial >= MaxSumOfHabTrial)
                meetCriterion = 1;
                pause(.3);
                SoundAlert;
            % If we haven't met criterion and haven't maxed out trials
            else
                % criterion starts at 0
                % critEndIndex starts at 0
                % AND we've done at least the minimum trials
                if ( (criterion ~= 0) && (trial >= (critEndIndex + 3)) && (trial >= MinSumOfHabTrial))
                    % if the sum of the timeon from the past 3 trials is below criterion
                    if (sum(habData(trial-2:trial, 3)) < criterion && ~fixedHabituation)
                        meetCriterion = 1;
                        pause(.3);
                        SoundAlert;
                    end
                end
            end

            % if the above has changed meetCriterion (we've done max trials, or met criterion)
            if (meetCriterion == 1)
                Draw_Hab_Message(win, 'MeetCriterion', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
                while (1)
                    [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
                    % on pressing c, continue hab; break the meetCriterion loop but move on to more hab trials
                    if (keyCode(KbName('C')))
                        break;
                    elseif (keyCode(KbName('T')))
                        % if T, move to test
                        totalObserverTime = totalObserverTime + observerTime;
                        exitHab = 1;
                        % 0 is bad trial
                        Write_Habituation_Looking_Data(fid, htmlFid, meetCriterion, 0, ...
                            SN, trial, condition, criterion, timeOn, timeOn2, ...
                            latency, timeOff, timeOff2, lookAway1, lookAway2, ...
                            AGR, SIM, KAPPA, fixedHabituation, fixedHabituationTime)
                        % leave the response for the meetCriterion screen
                        break;
                    end
                end
            end

            if (~exitHab)
                Draw_Hab_Message(win, 'ContinueNextTrail', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
            end
        else
            % if we've reached this top section after meeting criterion, set it to 2
            % bad trials will still write
            meetCriterion = 2;
            Draw_Hab_Message(win, 'ContinueNextTrail', trial, criterion, timeOn, meetCriterion, condition, 0, 0);
        end
    end

    % IF we haven't ended hab above, run a habituation trial
    % We are either on the Begin trial screen, or the continue screen
    if (~exitHab)
        while (1)
            [keyIsDOwn, Secs, keyCode, deltaSecs] = KbCheck(-1);
            % spacebar to start/continue a trial
            if (keyCode(KbName('Space')))
                if (trial > 0)
                    % If it's not the first trial, write the data
                    % 0 is bad trial
                    Write_Habituation_Looking_Data(fid, htmlFid, meetCriterion, 0, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, ...
                        latency, timeOff, timeOff2, lookAway1, lookAway2, ...
                        AGR, SIM, KAPPA, fixedHabituation, fixedHabituationTime)
                    % If there are exactly three rows,
                    % set the end index to 3, the start index to 1,
                    % and the criterion to tne sum of the first three rows criterion, halved
                    if (size(habData,1) == 3)
                        critEndIndex = size(habData,1);
                        critStartIndex = critEndIndex - 2;
                        criterion = sum(habData(critStartIndex:critEndIndex, 3))/2;
                    end
                    totalObserverTime = totalObserverTime + observerTime;
                end
                trial = trial + 1;
                break;
            % mark last trial as bad
            elseif ((trial > 0) && keyCode(KbName('B')))
                % this conditional isn't necessary
                if (trial > 0)
                    % wipe the row, and if the row resulted in criterion, undo that
                    habData(trial, :) = [];
                    if (meetCriterion == 1)
                        meetCriterion = 0;
                    end
                    % 1 is bad trial
                    Write_Habituation_Looking_Data(fid, htmlFid, meetCriterion, 1, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, ...
                        latency, timeOff, timeOff2, lookAway1, lookAway2, ...
                        AGR, SIM, KAPPA, fixedHabituation, fixedHabituationTime)
                end
                break;
            elseif (keyCode(KbName('T')))
                % set up for Tests
                if (trial > 0)
                    % record
                    % 0 is bad trial
                    Write_Habituation_Looking_Data(fid, htmlFid, meetCriterion, 0, ...
                        SN, trial, condition, criterion, timeOn, timeOn2, ...
                        latency, timeOff, timeOff2, lookAway1, lookAway2, ...
                        AGR, SIM, KAPPA, fixedHabituation, fixedHabituationTime)
                    totalObserverTime = totalObserverTime + observerTime;
                end
                % regardless of what trial we're on, exit hab
                exitHab = 1;
                break;
            end            
        end
        % TODO: rename this, it's the title-less column at the start
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

        % for fixed, wait on f press to start
        Draw_Hab_Message(win, 'FixedHabReadyScreen', trial, criterion, timeOn, meetCriterion, condition, 4, 0);
        while (1)
            [keyIsDown, Secs, keyCode, deltaSecs] = KbCheck(-1);
            if (keyCode(KbName('F')))
                break
            end
        end
        
        Draw_Hab_Message(win, 'BeginTrial', trial, criterion, timeOn, meetCriterion, condition, 4, 0);
        trialStart = GetSecs;
        while (1)
            [keyIsDown, Secs, keyCode, deltaSecs] = KbCheck(-1);
            coder1Response = 2 - keyCode(coder1ResponseKey);
            coder2Response = 2 - keyCode(coder2ResponseKey);
            errorKeyCode = keyCode;
            % response keys aren't considered errors
            errorKeyCode([coder1ResponseKey coder2ResponseKey]) = [];
            % search for keypresses that are NOT response keys
            % If not empty (we found a non-response keypress)
            % beep every second
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
            % Used for drawing message to indicate whether primary/secondary/both/none
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
%               Fixed trials don't end if timeOn exceeded; only after
%               fixedHabituationTime has passed
%                 if (sum(observerTime(1,:)) >= MaxHabTimeOn)
%                     SoundAlert;
%                     break;
%                 end
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
                if (startRecording && (Secs - lookAwayStartTime) >= LookAwayHab)
                    if (sum(observerTime(1,:)) < MinHabTimeOn)
                        observerTime = [0 0; 0 0];
                        startRecording = 0;
                        lookAway1 = 0;
                        lookAway2 = 0;
                        status = 'LookTooShort';
%                     Fixed habituation trials don't end on short looks; only after
%                     fixedHabituationTime has passed
%                     else
%                         SoundAlert;
%                         break;
                    end
                end
            end

            % If fixedHab and the trial time is at the fixedHabTime, stop
            % no matter what
            % .5 added to time to account for human delay
            if (fixedHabituation && GetSecs - trialStart >= (fixedHabituationTime + .5))
                SoundAlert;
                break;
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
    fixedHabituationTsvColumns = '';
    fixedHabituationHtmlColumns = '';
    if (fixedHabituation)
        fixedHabituationTsvColumns = '\t';
        fixedHabituationHtmlColumns = '<th></th>';
    end
    fprintf(fid, [fixedHabituationTsvColumns, '\tTOTAL\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n'], ...
        condition, criterion, sumData(3), sumData(4), sumData(5), ...
        sumData(6), sumData(7), sumData(8), sumData(9));
    fprintf(fid, [fixedHabituationTsvColumns, '\tMEAN\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n\n'], ...
        condition, criterion, meanData(3), meanData(4), meanData(5), ...
        meanData(6), meanData(7), meanData(8), meanData(9));

    fprintf(htmlFid, ...
        ['<tr>', fixedHabituationHtmlColumns,'<td>TOTAL</td><td>%s</td><td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td></td></tr>'], ...
        condition, criterion, sumData(3), sumData(4), sumData(5), ...
        sumData(6), sumData(8));
    fprintf(htmlFid, ...
        ['<tr>', fixedHabituationHtmlColumns,'<td>MEAN</td><td>%s</td><td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
         '<td></td></tr></table><br/>'], ...
        condition, criterion, meanData(3), meanData(4), meanData(5), ...
        meanData(6), meanData(8));
else
    fprintf(fid, '\n');
    fprintf(htmlFid, '</table><br/>');
end

%
% END HABITUATION
%