function [Voltage] = BatteryVoltageRoomba(serPort);
%Indicates the voltage of Create's battery in Volts


% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Voltage = nan;

try
    
%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td
fwrite(serPort, [142]);  fwrite(serPort,22);     %Changed to opcode 22

Voltage = fread(serPort, 1, 'uint16')/1000;

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end