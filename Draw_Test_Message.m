function Draw_Test_Message(win, status, testEvent, trial, timeOn, SN, responseStatus, time)
% This function is to draw text in windows in TEST according to STATUS
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
            [x, y] = Screen('DrawText', win, 'Begin Test', originX, y, textColor, bgColor);

            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['NEXT DISPLAY IS: ' testEvent], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'Press ''spacebar'': Continue with trial # 1', originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''S'': SAVE and EXIT.', originX, y, textColor, bgColor);

        case 'ContinueNextTrail'
            tempStr = ['TRIAL # ' int2str(trial) '  TIMEON = ' num2str(timeOn, '%.2f')];
            [x, y] = Screen('DrawText', win, tempStr, originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            tempStr = sprintf('Number of bad trials: %d out of %d', (SN - trial), SN); 
            [x, y] = Screen('DrawText', win, tempStr, originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['NEXT DISPLAY IS: ' testEvent], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['Press ''spacebar'': Continue with trial # ' int2str(trial+1)], originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            [x, y] = Screen('DrawText', win, 'Press ''B'': BAD trial and do over.', originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''S'': SAVE and EXIT.', originX, y, textColor, bgColor);

        case 'BadTrial'
            tempStr = ['TRIAL # ' int2str(trial) '  TIMEON = ' num2str(timeOn, '%.2f')];
            [x, y] = Screen('DrawText', win, tempStr, originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['STATUS: BAD trial was ===> ' testEvent], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, 'Press ''C'': Continue with next trial type.', originX, y, textColor, bgColor); 
            
            y = y + lineSpace;
            Screen('DrawText', win, 'Press ''R'': Repeat lst trial type.', originX, y, textColor, bgColor);
        
        case 'BeginTrial'
            [x, y] = Screen('DrawText', win, ['TEST TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['DISPLAY IS: ' testEvent], originX, y, textColor, bgColor); 
            
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
            [x, y] = Screen('DrawText', win, ['TEST TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);            
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['DISPLAY IS: ' testEvent], originX, y, textColor, bgColor);
            
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
            [x, y] = Screen('DrawText', win, ['TEST TRIAL # ' int2str(trial)], originX, y, textColor, bgColor);            
            
            y = y + sectionSpace;
            [x, y] = Screen('DrawText', win, ['DISPLAY IS: ' testEvent], originX, y, textColor, bgColor);
            
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
    end

    Screen('Flip', win);
end
