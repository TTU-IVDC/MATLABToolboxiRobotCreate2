%{
This example demonstrates two of the ways to control the Create2's wheels
1) SetFwdVelRadiusRoomba([Serial Port],[Forward Velocity(m/s)],[Radius])
   - Serial Port: Serial port object defined in RoombaInit
   - Forward Velocity: Value between -.5 and +.5 in m/s
   - Radius: + is CCW. - is CW. Valid Range is [-2,2].
      - Special Cases: Straight: inf
                       Turn in place CW: -eps
                       turn in place CCW: eps

2) SetDriveWheelsCreate([Serial Port], [RightWheel], [LeftWheel])
   - Serial Port: Serial port object defined in RoombaInit
   - Right Wheel: Right Wheel Velocity in m/s
   - Left Wheel: Left Wheel Velocity in m/s

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
% Read distance sensor (provides baseline)
InitDistance = DistanceSensorRoomba(serialObject)

%% Drive Method 1
% sets forward velocity .2 m/s and turning radius 2 m
SetFwdVelRadiusRoomba(serialObject, .2, 2);
% Note that a negative value will move in reverse
pause(1)   % wait 1 second
SetFwdVelRadiusRoomba(serialObject, 0, 1);    % stop the robot
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
% Counter-clockwise angles are positive and Clockwise angles are negative.
Angle = AngleSensorRoomba(serialObject)  %radians




pause(2)


%% Drive Method 2
%sets wheel velocity. (Serial Port , Right Wheel Vel. , Left Wheel vel.)
SetDriveWheelsCreate(serialObject, .2, .2);
%wait 1 second
pause(1)
% stop the robot
 SetDriveWheelsCreate(serialObject, 0, 0);
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
Angle = AngleSensorRoomba(serialObject)

pause(2)



%sets wheel velocity. (Serial Port , Right Wheel Vel. , Left Wheel vel.)
SetDriveWheelsCreate(serialObject, -.2, .2);
%wait 1 second
pause(1)
% stop the robot
SetDriveWheelsCreate(serialObject, 0, 0);
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
Angle = AngleSensorRoomba(serialObject)


