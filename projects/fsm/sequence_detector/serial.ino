    const int clockPin = 2; // Pin for clock signal
    const int dataPin = 5;  // Pin for data signal
    void setup() {
    pinMode(clockPin, OUTPUT);
    pinMode(dataPin, OUTPUT);
    Serial.begin(9600);
    }

    void loop() {
    int seq[100]={0,1,0,1,1,0};//input sequence
    for(int i=0;i<100;i++)
    {
    digitalWrite(clockPin, HIGH);
    delay(500); // clock frequency set to 1Hz
    digitalWrite(clockPin, LOW);
    delay(500);
    digitalWrite(dataPin,seq[i]);
    Serial.println(seq[i]);//display output to serial monitor
    
    }
    }
