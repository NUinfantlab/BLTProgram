function Test_Type_Window_Submitted(name, ...
          sbjNumber, gender, birthday, expDate, ...
          experimenter, coder1, coder2, studyName, ...
          condition, eventInputs, MaxTimeOn, ...
          MinTimeOn, LookAway, MinHabTrial, MaxHabTrial, age, ...
          MaxSumOfHabTrial, MinSumOfHabTrial)

    eventLabels = {};
    emptyFlag = 0;
    for e = 1:numel(eventInputs)
        eventLabels{e} = get(eventInputs{e}, 'String');
        if(isempty(eventLabels{e}))
            emptyFlag = 1;
        end
    end
    if (emptyFlag)
        uiwait(msgbox('All test field names must be filled out','Warning','modal'))
    else
        win = get(eventInputs{1}, 'Parent');
        close(win);
        Main;
    end
end