n = 5;
% Initialize Arduino communication
a = arduino('COM7', 'uno', 'libraries', 'ExampleLCD/LCDAddon', 'ForceBuildOn', true);

% Set up LCD addon
lcd = addon(a, 'ExampleLCD/LCDAddon', 'RegisterSelectPin', 'D7', 'EnablePin', 'D6', 'DataPins', {'D5', 'D4', 'D3', 'D2'});

% Initialize the LCD
initializeLCD(lcd);

% Configure light sensor on analog pin A0
lightSensorPin = 'A0';
LEDPin = 'D13'; % Corrected variable name and removed the extra space
configurePin(a, lightSensorPin, 'AnalogInput');

for iteration = 1:n
    % Number of readings for averaging
    numReadings = 100;
    
    % Initialize array to store light readings
    lightReadings = zeros(1, numReadings);
    
    % Read light sensor voltage over multiple readings
    for i = 1:numReadings
        lightReadings(i) = readVoltage(a, lightSensorPin);
        pause(0.1); % Adjust the delay based on your sensor's response time
    end
    
    % Calculate average light reading
    averageLight = mean(lightReadings);
    roundedAverageLight = round(averageLight, 1);
    message = ['light:' num2str(roundedAverageLight) 'V'];

    % Control the LED based on the average light reading
    if roundedAverageLight <= 1.5
        writeDigitalPin(a, LEDPin, 1); % Turn on the LED
    else
        writeDigitalPin(a, LEDPin, 0); % Turn off the LED
    end
    
    % Display average light on the LCD
    printLCD(lcd, message);
end

% Clear Arduino object to release the COM port
clear a;
