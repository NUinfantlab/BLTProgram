# BLT Program

This program handles tracking looking times for infant lab experiments.

It uses the Psychtoolbox Package to display screens.

# How to run

To run the experiment, download the files from this repository. Open the Matlab program. Use the command window to navigate to the folder containing the downloaded files.

If you're unfamiliar with the command windows, you can use the `ls` command to see the directories and files in your current location, and the `cd directory_name` command to move into a directory, or `cd ..` to move from your current directory to the parent of that directory. Imagine each cd command is opening another window in your Finder/Explorer to see the next folder.

Once you've navigated to the directory containing the files, run the Main_Gui command, and provide subject information and the habituation trials and times along with your study name. The program will run habituation trials first, followed by test trials. There will be on-screen prompts. Looking input is provided by shift keys (either on two separate keyboards, or the left and right shift keys on one keyboard).

After the test trials, the output of the looking times and other information will be written to an xls file, an html file, and a mat file, all containing the subject name and subject number in the filename. These will all be written to a Data folder.

The first Main_Gui run for an experiment will generate a new Main_Gui file for your study name, with the MaxTimeOn, LookAway, MaxSumOfHabTrial, MinSumOfHabTrial, MinTimeOn, and StudyName all set to the values provided in the first run by default. Use this file once it's generated for a given experiment, because Main_Gui will continue to generate new Gui files each time it is run.

# Aborting in case of error
In the event that Matlab fails (often indicated by an OSX error tone) while a full-screen display is up, there are a few methods to force-exit the experiment. Try the following in order:

1. Press ctrl+c to abort the program, then the return key to reach a new line in the Matlab Command Window, then type `clear` and press return. Ideally this will run clearing from the Command Window and close the full screen display.

1. If the above doesn't work, press option+apple+esc to force-quit Matlab

1. If none of the above work, reboot the computer. 

# Code Setup

The functions are separated into multiple files, which call each other to progress through the experiment. Running the experiment starts at the Main_Gui file.

### Main_Gui

Handles creating a GUI window to accept user input of experiment info. From this, the code moves on to Start_Button_Pressed or Close_Button_Pressed depending on which button was pressed.

Age is technically optional, and if it is not provided, will default to being empty.

If there is an Exp_Parameters file along with the Main_Gui file, the program will load parameters and variables from that file. Otherwise, it will load variables from  Default_Exp_Parameters.

#### Generate_New_Gui and Main_Gui_Template

Generate_New_Gui creates a new `.m` GUI file. It uses the template, which mostly matches Main_Gui, and fills in the following fields with values from the  Main_Gui input: MaxTimeOn, LookAway, MaxSumOfHabTrial, MinSumOfHabTrial, MinTimeOn, and StudyName. The file is saved as Main_Gui_StudyName.m (with StudyName filled in with the provided StudyName input). If a file with that name already exists, an extra character will be appended to the file name, e.g. Main_Gui_StudyName_1.m

After generating a Gui file for your experiment, from that point forward you should run BLT with the Study-specific Gui, instead of Main_Gui.

### Start_Button_Pressed and Close_Button_Pressed
Close_Button_Pressed ends the program.

Start_Button_Pressed handles a lot of validation for the inputs from the main GUI. It checks that fields that should be numbers are numbers, and etc. If run from the Main_Gui, and not a study-specific Gui file, it will also generate a GUI file using Generate_New_Gui and Main_Gui_Template.


After input validation, it opens the Test_Type_Input_Window

### Test_Type_Input_Window and Test_Type_Window_Submitted

This opens another Input Gui to accept Trial Label inputs. The number of labels depends on the "# of TestEvent Labels" input from the initial Gui screen.

The start button of this window progresses to Test_Type_Window_Submitted, which validates that all the test label input boxes were filled before running the Main program.

### Main
Main handles the rest of the program. It begins writing the data output files, and initiates the Habituation_Stage and Test_Stage processes. 

The output xls and HTML files are both written to separately, though the data used is the same. This is because the HTML output needs additional tags and formatting. If the files that Main would create already exist, it instead appends a character to the end of the filename. For example, if you would write another file named Jo_1.xls (for subject named Jo, with number 1), the output will instead be written to Jo_1_1.xls to avoid overwriting the existing file.

In the event of an error, an error file will be written containing the data gathered up to that point.

### Habituation_Stage and Test_Stage

Habituation_Stage runs the habituation screens, displaying prompts for proceeding and timing look on and look away times. Output is written to the output files after each trial finishes.

Test_Stage runs the test trials, in a similar manner to the habituation trials.

### Other Files

Compute_Agr, Compute_Kappa, and Compute_Similarity handle computations for output data. They calculate the observer agreement, Cohen's Kappa Coefficient, and observer similarity respectively.

Draw_Hab_Message and Draw_Test_Message create the full-screen prompts for the Habituation and Test stages. If you needed to change the display or text of those screens, you would change these functions.

Default_Exp_Parameters sets up some global variables used in Draw_Hab_Message. It isn't directly referenced in code, but the global variables are loaded by the Draw files.

SoundAlert makes a tone upon trial and stage completion.

13_martin appears to be an unused Gui file.