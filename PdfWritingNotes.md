# PDF Writing

As of June 2020, we haven’t been able to set up a way to write output neatly to PDF. Matlab Report Generator would potentially be able to convert the html output to a PDF, but we don’t have a license for it:

```
Error using mlreportgen.dom.Document/addHTMLFile
Unable to check out a Report Generator license. Reason: License checkout
failed.
License Manager Error -5
Cannot find a license for MATLAB_Report_Gen.
```

In the event that this license becomes available, we could try adding these imports to the top of the Main file:

```
import mlreportgen.dom.*
import mlreportgen.utils.*
```

And the following lower in main file, after the xls and HTML files are closed and saved with `save(strrep(fileName, '.xls', '.mat'));`:

```
pdfFileName = strrep(fileName, '.xls', '.pdf');
tidy(htmlFileName);
tidiedHtmlFileName = strrep(htmlFileName, '.html', '-tidied.html')
htmlFileObj = HTMLFile(tidiedHtmlFileName);
documentObj = Document(pdfFileName, 'pdf');
htmlObjOut = addHTMLFile(documentObj, tidiedHtmlFileName);
```

For more information on the above functions, see the Matlab documentation:

https://www.mathworks.com/help/rptgen/ug/mlreportgen.dom.htmlfile-class.html

http://mathworks.com/help/rptgen/ug/mlreportgen.dom.document-class.html