%{
This example demonstrates keyboard control of the iRobot Create.

Note: Unlike other functions, RobotHardKeyBoard input should be the COM
port you are using, not the declared serial object.

Note: Exiting keyboard control by any method other than pressing 'q' (e.g.
clicking the red x on the window) likely crash MATLAB.
%}

%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))

% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(8)


[keyPresses , elapsedTime] = RobotHardKeyBoard(1)

