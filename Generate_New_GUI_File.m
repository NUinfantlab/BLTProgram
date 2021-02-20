function Generate_New_GUI_File(MaxTimeOnHab, ...
    LookAwayHab, MaxSumOfHabTrial, MinTimeOnHab, MinSumOfHabTrial, ...
    StudyName, FixedHabituation, FixedHabituationTime, MaxSumOfTestTrial, ...
    MinTimeOnTest, MaxTimeOnTest, LookAwayTest)
foutName = strrep(StudyName, ' ', '');
foutName = ['Main_Gui_' foutName];
if (exist([foutName '.m'],'file'))
    i = '2';
    newFoutName = [foutName '_' i];
    while (exist([newFoutName '.m'],'file'))
        i = i+1;
        newFoutName = [foutName '_' i];
    end
    foutName = newFoutName;
end
fin = fopen('Main_Gui_Template.m');
fout = fopen([foutName '.m'], 'W+');


while ~feof(fin)
s = fgetl(fin);
s = strrep(s, '%%%StudyName%%%', StudyName);
s = strrep(s, '%%%FixedHabituation%%%', FixedHabituation);
s = strrep(s, '%%%FixedHabituationTime%%%', FixedHabituationTime);
s = strrep(s, '%%%MinSumOfHabTrial%%%', MinSumOfHabTrial);

s = strrep(s, '%%%MaxSumOfHabTrial%%%', MaxSumOfHabTrial);
s = strrep(s, '%%%MinHabTimeOn%%%', MinTimeOnHab);
s = strrep(s, '%%%MaxHabTimeOn%%%', MaxTimeOnHab);
s = strrep(s, '%%%LookAwayHab%%%', LookAwayHab);

s = strrep(s, '%%%MaxSumOfTestTrial%%%', MaxSumOfTestTrial);
s = strrep(s, '%%%MinTestTimeOn%%%', MinTimeOnTest);
s = strrep(s, '%%%MaxTestTimeOn%%%', MaxTimeOnTest);
s = strrep(s, '%%%LookAwayTest%%%', LookAwayTest);

fprintf(fout,'%s\n',s);
disp(s);
end

fclose(fin);
fclose(fout);

end