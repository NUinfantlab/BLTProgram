function Start_Button_Pressed(nameInput, ...
    sbjNumberInput, genderInput, birthdayInput, expDateInput, ...
    experimenterInput, coder1Input, coder2Input, studyNameInput, ...
    conditionInput, numLabels, maxTimeOnInput, ...
    minTimeOnInput, lookAwayInput, minHabTrialInput, maxHabTrialInput, ...
    generateNewGUI, ageInput)
% GenerateNewGUI and age are optional
if nargin < 17 || isempty(generateNewGUI)
    generateNewGUI = 0;
end
if (nargin < 18)
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

maxTimeOn = get(maxTimeOnInput, 'string');
minTimeOn = get(minTimeOnInput, 'string');
lookAway = get(lookAwayInput, 'string');
minHabTrial = get(minHabTrialInput, 'string');
maxHabTrial = get(maxHabTrialInput, 'string');

if (regexp(gender, '^[fmFM]$') ~= [])
end
if (strcmp(name, '') || strcmp(sbjNumber, '') || ...
        strcmp(gender, '') || strcmp(birthday, '') || strcmp(age, '') ||...
        strcmp(expDate, '') || strcmp(experimenter, '') || ...
        strcmp(coder1, '') || strcmp(studyName, '') || ...
        strcmp(condition, '') || strcmp(numLabels, '') || ...
        strcmp(maxTimeOn, '') || ...
        strcmp(minTimeOn, '') || strcmp(lookAway, '') || ...
        strcmp(minHabTrial, '') || strcmp(maxHabTrial, ''))
    uiwait(msgbox('Please fill out all required fields!','Warning','modal'));
else
    [maxTimeOn, maxTimeOnValid] = str2num(maxTimeOn);
    [minTimeOn, minTimeOnValid] = str2num(minTimeOn);
    [lookAway, lookAwayValid] = str2num(lookAway);
    [minSumOfHabTrial, minHabTrialValid] = str2num(minHabTrial);
    [maxSumOfHabTrial, maxHabTrialValid] = str2num(maxHabTrial);
    [numLabels, numLabelsValid] = str2num(numLabels);

    if (~maxTimeOnValid)
        uiwait(msgbox('The field "Max Time On" must be a number. ','Warning','modal'));
    elseif (~minTimeOnValid)
        uiwait(msgbox('The field "Min Time On" must be a number. ','Warning','modal'))
    elseif (~lookAwayValid)
        uiwait(msgbox('The field "Look Away" must be a number. ','Warning','modal'))
    elseif (~minHabTrialValid)
        uiwait(msgbox('The field "Min # of Hab. Trial" must be a number. ','Warning','modal'))
    elseif (~maxHabTrialValid)
        uiwait(msgbox('The field "Max # of Hab. Trial" must be a number. ','Warning','modal'))
    elseif (maxSumOfHabTrial < minSumOfHabTrial)
        uiwait(msgbox('The field "Max # of Hab. Trial" must not be smaller than "Max # of Hab. Trial". ','Warning','modal'))
    elseif (~numLabelsValid || numLabels <= 0 || numLabels > 20)
        uiwait(msgbox('The field "# of TestEvent Labels (*)" must be a number between 1 and 20 (inclusive)','Warning','modal'))
    else
        % save experiment settings
        if (generateNewGUI == 1)
            Generate_New_GUI_File(num2str(maxTimeOn), num2str(lookAway),...
                num2str(maxSumOfHabTrial), num2str(minTimeOn), ...
                num2str(minSumOfHabTrial), num2str(studyName));
        end

        clear maxTimeOnValid minTimeOnValid lookAwayValid minHabTrialValid maxHabTrialValid;

        win = get(nameInput, 'Parent');
        close(win);
        Test_Type_Input_Window(name, ...
          sbjNumber, gender, birthday, expDate, ...
          experimenter, coder1, coder2, studyName, ...
          condition, numLabels, maxTimeOn, ...
          minTimeOn, lookAway, minHabTrial, maxHabTrial, age, ...
          maxSumOfHabTrial, minSumOfHabTrial)
    end
end

end