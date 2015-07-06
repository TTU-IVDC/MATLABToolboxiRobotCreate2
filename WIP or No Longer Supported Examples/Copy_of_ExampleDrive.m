%{
This example demonstrates two of the ways to control the Create's wheels
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

clear all;
clc

%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))

% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(6)
% Read distance sensor (provides baseline)
InitDistance = DistanceSensorRoomba(serialObject)






travelDist(serialObject, 0.1, 0.2);










SetDriveWheelsCreate(serialObject, 0, 0);
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
Angle = AngleSensorRoomba(serialObject)

