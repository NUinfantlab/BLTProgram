function Write_File_Comments(src, event, parent, ...
    fileName, htmlFileName, commentInput)
    comments = get(commentInput, 'String');
    close(parent);
    if (~strcmpi(comments, ''))
        xlsfid = fopen(fileName, 'a+');
        htmlFid = fopen(htmlFileName, 'a+');
        csvfid = fopen(strrep(fileName, '.xls', '.csv'), 'a+');
        matfid = fopen(strrep(fileName, '.xls', '.mat'), 'a+');
        
        fprintf(xlsfid, 'Comments: %s \n\n', comments);
        fprintf(htmlFid, '<p><b>Comments: </b>%s </p></body>', comments);
        fprintf(csvfid, 'Comments: %s \n\n', comments);
        fprintf(matfid, 'Comments: %s \n\n', comments);
        fclose('all');
    end
end