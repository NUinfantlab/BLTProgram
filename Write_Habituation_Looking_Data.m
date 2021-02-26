function Write_Habituation_Looking_Data(fid, htmlFid, meetCriterion, badTrial, ...
    SN, trial, condition, criterion, timeOn, timeOn2, ...
    latency, timeOff, timeOff2, lookAway1, lookAway2, ...
    AGR, SIM, KAPPA, fixedHabituation, fixedHabituationTime)
    tsvFormat = Get_File_Columns('tsv', 'hab', meetCriterion, badTrial, fixedHabituation);
    htmlFormat = Get_File_Columns('html', 'hab', meetCriterion, badTrial, fixedHabituation);
    columnBg = '#FFFFFF';
    if (trial <= 3)
        columnBg = '#DDDDDD';
    end
    if (fixedHabituation)
        fprintf(fid, tsvFormat, SN, fixedHabituationTime, ...
            trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);
        fprintf(htmlFid, htmlFormat, columnBg, fixedHabituationTime, ...
            trial, condition, criterion, timeOn, timeOn2, latency, timeOff, lookAway1, AGR);
    else
        fprintf(fid, tsvFormat, ...
            SN, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, timeOff2, lookAway1, lookAway2, AGR, SIM, KAPPA);
        fprintf(htmlFid, htmlFormat, ...
            columnBg, trial, condition, criterion, timeOn, timeOn2, latency, timeOff, lookAway1, AGR);
    end
    clear tsvFormat htmlFormat columnBg;