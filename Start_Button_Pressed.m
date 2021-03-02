function Start_Button_Pressed(nameInput, ...
    sbjNumberInput, genderInput, birthdayInput, expDateInput, ...
    experimenterInput, coder1Input, coder2Input, studyNameInput, ...
    conditionInput, numLabels, maxHabTimeOnInput, maxTestTimeOnInput, ...
    minHabTimeOnInput, minTestTimeOnInput, lookAwayHabInput, lookAwayTestInput, ...
    minHabTrialInput, maxHabTrialInput, maxTestTrialInput, ...
    generateNewGUI, ageInput, fixedHabituationInput, fixedHabituationTimeInput)
% fixedHabituation (handled later), GenerateNewGUI and age are optional
if nargin < 21 || isempty(generateNewGUI)
    generateNewGUI = 0;
end
if (nargin < 22)
    age = '';
else
    age = get(ageInput, 'String');
end
name = get(nameInput, 'String');
sbjNumber = get(sbjNumberInput, 'String');
gender = get(genderInput, 'String');
birthday = get(birthdayInput, 'String');
expDate = get(expDateInput, 'String');
experimenter = get(experimenterInput, 'String');
coder1 = get(coder1Input, 'String');
coder2 = get(coder2Input, 'String');
studyName = get(studyNameInput, 'String');
condition = get(conditionInput, 'String');
numLabels = get(numLabels, 'String');

maxHabTimeOn = get(maxHabTimeOnInput, 'string');
minHabTimeOn = get(minHabTimeOnInput, 'string');
lookAwayHab = get(lookAwayHabInput, 'string');
minHabTrial = get(minHabTrialInput, 'string');
maxHabTrial = get(maxHabTrialInput, 'string');

maxTestTimeOn = get(maxTestTimeOnInput, 'string');
minTestTimeOn = get(minTestTimeOnInput, 'string');
lookAwayTest = get(lookAwayTestInput, 'string');
maxTestTrial = get(maxTestTrialInput, 'string');

if (regexp(gender, '^[fmFM]$') ~= [])
end
if (strcmp(name, '') || strcmp(sbjNumber, '') || ...
        strcmp(gender, '') || strcmp(birthday, '') || strcmp(age, '') ||...
        strcmp(expDate, '') || strcmp(experimenter, '') || ...
        strcmp(coder1, '') || strcmp(studyName, '') || ...
        strcmp(condition, '') || strcmp(numLabels, '') || ...
        strcmp(maxHabTimeOn, '') || ...
        strcmp(minHabTimeOn, '') || strcmp(lookAwayHab, '') || ...
        strcmp(minHabTrial, '') || strcmp(maxHabTrial, '') || ...
        strcmp(maxTestTimeOn, '') || strcmp(minTestTimeOn, '') || ...
        strcmp(lookAwayTest, '') || strcmp(maxTestTrial, ''))
    uiwait(msgbox('Please fill out all required fields!','Warning','modal'));
else
    [maxHabTimeOn, maxHabTimeOnValid] = str2num(maxHabTimeOn);
    [minHabTimeOn, minHabTimeOnValid] = str2num(minHabTimeOn);
    [lookAwayHab, lookAwayHabValid] = str2num(lookAwayHab);
    [minSumOfHabTrial, minHabTrialValid] = str2num(minHabTrial);
    [maxSumOfHabTrial, maxHabTrialValid] = str2num(maxHabTrial);
    
    [maxTestTimeOn, maxTestTimeOnValid] = str2num(maxTestTimeOn);
    [minTestTimeOn, minTestTimeOnValid] = str2num(minTestTimeOn);
    [lookAwayTest, lookAwayTestValid] = str2num(lookAwayTest);
    [maxSumOfTestTrial, maxTestTrialValid] = str2num(maxTestTrial);
    
    [numLabels, numLabelsValid] = str2num(numLabels);
    
    fixedHabituation = 0;
    fixedHabituationTime = 0;
    if (nargin >= 23)
        fixedHabituation = get(fixedHabituationInput, 'Value');
        if (fixedHabituation)
            [fixedHabituationTime, fixedHabituationTimeValid] = str2num(get(fixedHabituationTimeInput, 'String'));
        end
    end

    if (~maxHabTimeOnValid)
        uiwait(msgbox('The field "Max Time On" must be a number. (Habituation)','Warning','modal'));
    elseif (~minHabTimeOnValid)
        uiwait(msgbox('The field "Min Time On" must be a number. (Habituation)','Warning','modal'))
    elseif (~lookAwayHabValid)
        uiwait(msgbox('The field "Look Away" must be a number. (Habituation)','Warning','modal'))
    elseif (~minHabTrialValid)
        uiwait(msgbox('The field "Min # of Hab. Trial" must be a number. ','Warning','modal'))
    elseif (~maxHabTrialValid)
        uiwait(msgbox('The field "Max # of Trial" must be a number. (Habituation)','Warning','modal'))
    elseif (maxSumOfHabTrial < minSumOfHabTrial)
        uiwait(msgbox('The field "Max # of Hab. Trial" must not be smaller than "Max # of Hab. Trial". ','Warning','modal'))
    elseif(~maxTestTimeOnValid)
        uiwait(msgbox('The field "Max Time On" must be a number. (Test)','Warning','modal'));
    elseif (~minTestTimeOnValid)
        uiwait(msgbox('The field "Min Time On" must be a number. (Test)','Warning','modal'))
    elseif (~lookAwayTestValid)
        uiwait(msgbox('The field "Look Away" must be a number. (Test)','Warning','modal'))
    elseif (~maxTestTrialValid)
        uiwait(msgbox('The field "Max # of Trial" must be a number. (Test)','Warning','modal'))
    elseif (~numLabelsValid || numLabels <= 0 || numLabels > 20)
        uiwait(msgbox('The field "# of TestEvent Labels (*)" must be a number between 1 and 20 (inclusive)','Warning','modal'))
    elseif (fixedHabituation && nargin < 18)
        uiwait(msgbox('Fixed Habituation requires a Fixed Habituation Time','Warning','modal'))
    elseif (fixedHabituation && ~fixedHabituationTimeValid)
        uiwait(msgbox('Fixed Habituation Time must be a positive number','Warning','modal'))
    else
        % save experiment settings
        if (generateNewGUI == 1)
            Generate_New_GUI_File(num2str(maxHabTimeOn), num2str(lookAwayHab),...
                num2str(maxSumOfHabTrial), num2str(minHabTimeOn), ...
                num2str(minSumOfHabTrial), num2str(studyName), ...
                num2str(fixedHabituation), num2str(fixedHabituationTime), ...
                num2str(maxTestTimeOn), num2str(lookAwayTest),...
                num2str(maxSumOfTestTrial), num2str(minTestTimeOn));
        end

        clear maxHabTimeOnValid minHabTimeOnValid lookAwayHabValid minHabTrialValid maxHabTrialValid ...
            maxTestTimeOnValid minTestTimeOnValid lookAwayTestValid maxTestTrialValid;

        win = get(nameInput, 'Parent');
        close(win);
        Test_Type_Input_Window(name, ...
          sbjNumber, gender, birthday, expDate, ...
          experimenter, coder1, coder2, studyName, ...
          condition, numLabels, maxHabTimeOn, ...
          minHabTimeOn, lookAwayHab, minHabTrial, maxHabTrial, age, ...
          maxSumOfHabTrial, minSumOfHabTrial, fixedHabituation, ...
          fixedHabituationTime, maxTestTimeOn, ...
          minTestTimeOn, lookAwayTest, maxTestTrial, ...
          maxSumOfTestTrial)
    end
end

end