function Draw_Hab_Message(win, status, trial, criterion, timeOn, meetCriterion, condition, responseStatus, time);
% This function is to draw text in windows in HABITUAION according to STATUS
%
    global bgColor;
    global textColor;
    global originX;
    global originY;
    global lineSpace;
    global sectionSpace;
    global bigTextStyle;
    global bigTextSize;
    global textStyle;
    global textSize;

    y = originY;
    switch (status)
        case 'Begin'
            [x, y] = Screen('DrawText', win, 'Begin Habituation', originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'Press ''spacebar'': Continue with trial # 1', originX, y, textColor, bgColor);
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''T'': Abort habituation - goto TEST.', originX, y, textColor, bgColor);

        case 'MeetCriterion'
            [x, y] = Screen('DrawText', win, ['HABITUATION TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['CRITERION IS SET AT: ' num2str(criterion, '%.2f')], originX, y, textColor, bgColor); 
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'STATUS: CRITERION HAS BEEN MET!', originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'Press ''C'': Continue with more HABITUATION trials.', originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''T'': Go on to TEST trials.', originX, y, textColor, bgColor); 
        
        case 'ContinueNextTrail'
            tempStr = ['HABITUATION TRIAL # ' int2str(trial) '  TIMEON = ' num2str(timeOn, '%.2f')];
            [x, y] = Screen('DrawText', win, tempStr, originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            if (meetCriterion > 0)
                [x, y] = Screen('DrawText', win, 'CRITERION IS SET AT: ===> CRITERION HAS BEEN MET', originX, y, textColor, bgColor); 
            else
                [x, y] = Screen('DrawText', win, ['CRITERION IS SET AT: ' num2str(criterion, '%.2f')], originX, y, textColor, bgColor); 
            end
            
            y = y + lineSpace;
            [x, y] = Screen('DrawText', win, ['HABITUATION CONDITION: ' condition], originX, y, textColor, bgColor);

            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['Press ''spacebar'': Continue with trial # ' int2str(trial+1)], originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            [x, y] = Screen('DrawText', win, 'Press ''B'': BAD trial and re-do the trial.', originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''T'': Abort the habituation - goto TEST.', originX, y, textColor, bgColor);
        
        case 'BeginTrial'
            [x, y] = Screen('DrawText', win, ['HABITUATION TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            if (meetCriterion > 0)
                [x, y] = Screen('DrawText', win, 'CRITERION IS SET AT: ===> CRITERION HAS BEEN MET', originX, y, textColor, bgColor); 
            else
                [x, y] = Screen('DrawText', win, ['CRITERION IS SET AT: ' num2str(criterion, '%.2f')], originX, y, textColor, bgColor);
            end
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['HABITUATION CONDITION: ' condition], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'STATUS: Waiting for first look...', originX, y, textColor, bgColor); 
        
            y = y + sectionSpace;
            switch (responseStatus)
                case 1
                    Screen('DrawText', win, 'primary secondary :  0', originX, y, textColor, bgColor);
                case 2
                    Screen('DrawText', win, '------- secondary :  0', originX, y, textColor, bgColor);
                case 3
                    Screen('DrawText', win, 'primary --------- :  0', originX, y, textColor, bgColor);
                case 4
                    Screen('DrawText', win, '------- --------- :  0', originX, y, textColor, bgColor);
            end

            Screen('TextStyle', win, bigTextStyle);
            Screen('TextSize', win, bigTextSize);

            y = y + sectionSpace;
            Screen('DrawText', win, 'Recording', originX, y, textColor, bgColor);

            Screen('TextStyle', win, textStyle);
            Screen('TextSize', win, textSize);

        case 'LookTooShort'
            [x, y] = Screen('DrawText', win, ['HABITUATION TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);            
            
            y = y + sectionSpace;
            if (meetCriterion > 0)
                [x, y] = Screen('DrawText', win, 'CRITERION IS SET AT: ===> CRITERION HAS BEEN MET', originX, y, textColor, bgColor); 
            else
                [x, y] = Screen('DrawText', win, ['CRITERION IS SET AT: ' num2str(criterion, '%.2f')], originX, y, textColor, bgColor);
            end
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['HABITUATION CONDITION: ' condition], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'STATUS: Looking time too short! Waiting for look...', originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            switch (responseStatus)
                case 1
                    Screen('DrawText', win, ['primary secondary :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 2
                    Screen('DrawText', win, ['------- secondary :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 3
                    Screen('DrawText', win, ['primary --------- :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 4
                    Screen('DrawText', win, ['------- --------- :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
            end

            Screen('TextStyle', win, bigTextStyle);
            Screen('TextSize', win, bigTextSize);

            y = y + sectionSpace;
            Screen('DrawText', win, 'Recording', originX, y, textColor, bgColor);

            Screen('TextStyle', win, textStyle);
            Screen('TextSize', win, textSize);


        case 'FirstLookRecorded'
            [x, y] = Screen('DrawText', win, ['HABITUATION TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            if (meetCriterion > 0)
                [x, y] = Screen('DrawText', win, 'CRITERION IS SET AT: ===> CRITERION HAS BEEN MET', originX, y, textColor, bgColor); 
            else
                [x, y] = Screen('DrawText', win, ['CRITERION IS SET AT: ' num2str(criterion, '%.2f')], originX, y, textColor, bgColor);
            end
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['HABITUATION CONDITION: ' condition], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'STATUS: First look has been recorded.', originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            switch (responseStatus)
                case 1
                    Screen('DrawText', win, ['primary secondary :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 2
                    Screen('DrawText', win, ['------- secondary :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 3
                    Screen('DrawText', win, ['primary --------- :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
                case 4
                    Screen('DrawText', win, ['------- --------- :  ' num2str(time, '%.1f')], originX, y, textColor, bgColor);
            end

            Screen('TextStyle', win, bigTextStyle);
            Screen('TextSize', win, bigTextSize);

            y = y + sectionSpace;
            Screen('DrawText', win, 'Recording', originX, y, textColor, bgColor);

            Screen('TextStyle', win, textStyle);
            Screen('TextSize', win, textSize);
        case 'FixedHabReadyScreen'
            [x, y] = Screen('DrawText', win, 'Begin Fixed Habituation', originX, y, textColor, bgColor);
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'Press ''f'': Start Trial', originX, y, textColor, bgColor);
    end
    Screen('Flip', win);
end
