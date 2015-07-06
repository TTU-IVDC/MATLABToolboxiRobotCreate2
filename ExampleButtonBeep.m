%{
This example demonstrates the use of the Create2's  buttons.
When in Full or Safe Mode, these buttons may be read as a digital inputs.
The function ButtonSensorRoomba returns 1 for depressed and 0 for not
depressed.

The BeepRoomba function causes the Roomba to beep once. Note: Calling this
function in quick succession will likely result in a single beep. A pause
is necessary for multiple beeps.

In this example pressing the Create's buttons causes the following effects.
* Day - Beep Once
* Minute -    Beep Twice
* Both -    Beep Three Times

Note: There seems to be an issue with the schedule and clock buttons.
Note: Set Serial Port to port connected to Create
%}
%% General Initialization
clear all;
close all;
clc
%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))

% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(8)
format compact

%% Button Example
%Schedule and clock do not appear to be working. All else are fine.(4/20/15)

for n = 1:10
[ButtonClean, ButtonSpot, ButtonDock, ButtonMinute, ButtonHour...
    ButtonDay, ButtonSchedule, ButtonClock] = ButtonsSensorRoomba(serialObject)
   
if ButtonDay * ButtonMinute == 1    % Both buttons are depressed
    BeepRoomba(serialObject);
    pause (.5);
    BeepRoomba(serialObject);
    pause (.5);
    BeepRoomba(serialObject);
    
elseif ButtonDay == 1             % Advance button is depressed
    BeepRoomba(serialObject);
        
elseif ButtonMinute == 1            % Play button is depressed
    BeepRoomba(serialObject);
    pause (.5);
    BeepRoomba(serialObject);
end
pause (1);
end