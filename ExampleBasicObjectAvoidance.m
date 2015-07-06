%{
This example demonstrates the implementation of basic object avoidance
using the Create's bump sensors. 

The Create drives forward until it encounters and object and turns away
from it. Pressing either button (Advance or Play) while running stops the
Create.

Note: Set Serial Port to port connected to Create
Note: ctrl + c stops execution of MATLAB code
%}
clc
clear all
close all
%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))

% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(8)

format compact  % Changes the output in the Command Window

for x = 1:1000
[ButtonAdv,ButtonPlay] = ButtonsSensorRoomba(serialObject)
if ButtonAdv == 1 || ButtonPlay == 1
    SetDriveWheelsCreate(serialObject, 0, 0);
    break
end
   

%sets wheel velocity. (Serial Port , Right Wheel Vel. , Left Wheel vel.)
SetDriveWheelsCreate(serialObject, .2, .2);



[BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serialObject)

if BumpFront == 1
    travelDist(serialObject, .2, -.1);
   % pause (.1)
    turnAngle(serialObject, .2, 180)
    pause(.1)
end

if BumpLeft == 1
    travelDist(serialObject, .2, -.1)
    %pause (.1)
    turnAngle(serialObject, .2, -90)
    pause(.1)
end

if BumpRight == 1
    travelDist(serialObject, .2, -.1)
    %pause (.1)
    turnAngle(serialObject, .2, 90)
    pause(.1)
end    



end

