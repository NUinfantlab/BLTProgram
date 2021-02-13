function File_Comments_Window(fileName, htmlFileName)
    Screen('Preference', 'SkipSyncTests', 1);
    screenSize = get(0, 'ScreenSize');
    width = round(screenSize(3) * 0.9);
    height = round(screenSize(4) * 0.85);
    y = (screenSize(4) - height)/2;
    x = (screenSize(3) - width)/2;
    fileCommentWin = figure('Name', 'File Comments', ...
        'Position', [x y  width height], ...
        'MenuBar', 'none', 'ToolBar', 'none', 'Color', [0.9 0.9 0.9]);
    figure(fileCommentWin);
    parentColor = get(fileCommentWin, 'Color');

    labelW = (width - 50) / 4;
    if (labelW > 280)
        labelW = 280;
    end
    labelH = floor((height - 70 - 13 * 5)/13);
    uiFontSize = 16;

    y = height - 85;
    left = 10;
    x = labelW+20;
        %draw input

    uicontrol( ...
        'Parent', fileCommentWin, ...
        'Style', 'text', ...
        'String', 'Comments for output', ...
        'Position', [left y labelW labelH], ...
        'backgroundcolor', parentColor,...
        'HorizontalAlignment','left', ...
        'FontSize', uiFontSize, ...
        'FontUnits', 'pixels');
    commentInput = uicontrol(...
        'Parent', fileCommentWin, ...
        'Style', 'edit', ...
        'HorizontalAlignment','left', ...
        'Position', [x y labelW+(width/3) labelH], ...
        'backgroundcolor', parentColor, ...
        'String', '', ...
        'FontSize', uiFontSize);

    buttonY = height - 65 - labelH*10 - 100;
    buttonX = (width - (labelW*2 + 10)) /2;
    uicontrol('Parent', fileCommentWin, ...
            'Style', 'pushbutton', ...
            'String', 'Add Comment', ...
            'FontSize', uiFontSize, ...
            'Position', [buttonX buttonY labelW labelH], ...
            'callback', @(src,event)Write_File_Comments(src,event, ...
                fileCommentWin, fileName, htmlFileName, commentInput));

end

