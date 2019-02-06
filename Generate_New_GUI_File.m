function Generate_New_GUI_File(MaxTimeOn, ...
    LookAway, MaxSumOfHabTrial, MinTimeOn, MinSumOfHabTrial, ...
    StudyName)
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
s = strrep(s, '%%%MaxTimeOn%%%', MaxTimeOn);
s = strrep(s, '%%%LookAway%%%', LookAway);
s = strrep(s, '%%%MaxSumOfHabTrial%%%', MaxSumOfHabTrial);
s = strrep(s, '%%%MinSumOfHabTrial%%%', MinSumOfHabTrial);
s = strrep(s, '%%%MinTimeOn%%%', MinTimeOn);
s = strrep(s, '%%%StudyName%%%', StudyName);
fprintf(fout,'%s\n',s);
disp(s);
end

fclose(fin);
fclose(fout);

end