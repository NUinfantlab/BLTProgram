function result = Get_File_Columns(fileType, trialType, meetCriterion, badTrial, isFixedHabituation)
    trialPrefix = '';
    fixedHabituationTsvColumns = '';
    fixedHabituationHtmlColumns = '';
    if (meetCriterion > 0)
        trialPrefix = 'C ';
    end
    if (badTrial > 0)
        trialPrefix = ['B ', trialPrefix];
    end
    if (strcmpi(trialType, 'hab'))
        if (nargin >= 4 && isFixedHabituation)
            fixedHabituationTsvColumns = '%d\t';
            fixedHabituationHtmlColumns = '<td>%d</td>';
        end
        if (strcmpi(fileType, 'html'))
            result = ['<tr bgcolor="%s">', fixedHabituationHtmlColumns, ...
                    '<td>', trialPrefix, ...
                    '%d</td><td>%s</td>' ...
                    '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                    '<td>%.2f</td><td>%.2f</td>' ...
                    '<td>%d</td><td>%.2f</td>' ...
                    '<td>%.2f</td><td>%.2f</td></tr>'];
        else
            result = ['%d\t', fixedHabituationTsvColumns, trialPrefix, ...
                '%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n'];
        end
    else
        if (nargin >= 4 && isFixedHabituation)
            fixedHabituationTsvColumns = '%d\t\t';
        end
        if (strcmpi(fileType, 'html'))
            result = ['<tr bgcolor="%s"><td>', trialPrefix, '%d</td><td>%s</td>' ...
                          '<td>%.2f</td><td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td><td>%d</td>' ...
                          '<td>%.2f</td><td>%.2f</td>' ...
                          '<td>%.2f</td></tr>'];
        else
            result = ['%d\t', fixedHabituationTsvColumns, trialPrefix, ...
                '%d\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d\t%.2f\t%.2f\t%.2f\n'];
        end
    end