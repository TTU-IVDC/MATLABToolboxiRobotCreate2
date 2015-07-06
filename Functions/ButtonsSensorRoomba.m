function [ButtonClean, ButtonSpot, ButtonDock, ButtonMinute, ButtonHour...
    ButtonDay, ButtonSchedule, ButtonClock] = ButtonsSensorRoomba(serPort);
%[ButtonAdv,ButtonPlay] = ButtonsSensorRoomba(serPort)
%Displays the state of Create's Play and Advance buttons, either pressed or
%not pressed.

%initialize preliminary return values
% ButtonAdv = nan;
% ButtonPlay = nan;
ButtonClean = nan;
ButtonSpot = nan;
ButtonDock = nan;
ButtonMinute = nan;
ButtonHour = nan;
ButtonDay = nan;
ButtonSchedule = nan;
ButtonClock = nan;
 
% By; Joel Esposito, US Naval Academy, 2011
try
    
%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td


fwrite(serPort, [142]);  
fwrite(serPort, [18]);

Buttons = dec2bin(fread(serPort, 1, 'uint8'),8);
ButtonClean = bin2dec(Buttons(end));
ButtonSpot = bin2dec(Buttons(end-1));
ButtonDock = bin2dec(Buttons(end-2));
ButtonMinute = bin2dec(Buttons(end-3));
ButtonHour = bin2dec(Buttons(end-4));
ButtonDay = bin2dec(Buttons(end-5));
ButtonSchedule = bin2dec(Buttons(end-6));
ButtonClock = bin2dec(Buttons(end-7));


pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end