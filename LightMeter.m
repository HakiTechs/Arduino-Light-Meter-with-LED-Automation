a = arduino('COM7', 'Uno'); 
lightSensorPin = 'A0';
LEDPin = 'D13';

configurePin(a, lightSensorPin, 'AnalogInput');

startTime = tic;  % Record the start time

while toc(startTime) <= 120  % Run for 2 minutes (120 seconds)
    sens = readVoltage(a, lightSensorPin);

    if sens <= 1.5
        writeDigitalPin(a, LEDPin, 1); % Turn on the LED
    else
        writeDigitalPin(a, LEDPin, 0); % Turn off the LED
    end
    
    pause(0.1); % Add a small delay to avoid rapid loop execution
end

% Turn off the LED before exiting
writeDigitalPin(a, LEDPin, 0);

clear a;
