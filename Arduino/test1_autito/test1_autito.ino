#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "terreneitor";
const char* password = "12345678";

#define ENA   2     // Enable/speed motors Right    GPIO2
#define IN_1  14    // L298N in1 motors Right       GPIO14
#define IN_2  15    // L298N in2 motors Right       GPIO15
#define IN_3  12    // L298N in3 motors Left        GPIO12
#define IN_4  13    // L298N in4 motors Left        GPIO13
#define ENB   4     // Enable/speed motors Left     GPIO4

//#define Light  16   // Light  GPIO16

String command;             //String to store app command state.
int speedCar = 150; // 0 to 255
int speed_low = 60;

WebServer server(80);

void setup() {
  Serial.begin(115200);

  pinMode(ENA, OUTPUT); 
  pinMode(IN_1, OUTPUT);
  pinMode(IN_2, OUTPUT);
  pinMode(IN_3, OUTPUT);
  pinMode(IN_4, OUTPUT);
  pinMode(ENB, OUTPUT); 

//  pinMode(Light, OUTPUT); 
  
  WiFi.begin(ssid, password);
  
  Serial.print("Conectando a ");
  Serial.println(ssid);
  
  // Espera a que se conecte
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.println("Conexión establecida!");
  Serial.print("Dirección IP asignada: ");
  Serial.println(WiFi.localIP());
  WiFi.softAP(ssid, password);
 
  server.on("/", HTTP_handleRoot);
  server.onNotFound(HTTP_handleRoot);
  server.begin();    
}

void loop() {
  server.handleClient();
  
  command = server.arg("State");
  if (command == "F") goForward();
  else if (command == "B") goBack();
  else if (command == "L") goLeft();
  else if (command == "R") goRight();
  else if (command == "I") goForwardRight();
  else if (command == "G") goForwardLeft();
  else if (command == "J") goBackRight();
  else if (command == "H") goBackLeft();
  //else if (command == "W") digitalWrite(Light, HIGH); // luces
  //else if (command == "w") digitalWrite(Light, LOW);  // no luces
  else if (command == "0") speedCar = 100;
  else if (command == "1") speedCar = 120;
  else if (command == "2") speedCar = 140;
  else if (command == "3") speedCar = 160;
  else if (command == "4") speedCar = 180;
  else if (command == "5") speedCar = 200;
  else if (command == "6") speedCar = 215;
  else if (command == "7") speedCar = 230;
  else if (command == "8") speedCar = 240;
  else if (command == "9") speedCar = 255;
  else if (command == "S") stopRobot();
}

void HTTP_handleRoot() {
  if (server.hasArg("State")) {
    Serial.println(server.arg("State"));
  }
  server.send(200, "text/html", "");
}

void goForward() { 
  digitalWrite(IN_1, HIGH);
  digitalWrite(IN_2, LOW);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, LOW);
  digitalWrite(IN_4, HIGH);
  analogWrite(ENB, speedCar);
}

void goBack() { 
  digitalWrite(IN_1, LOW);
  digitalWrite(IN_2, HIGH);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, HIGH);
  digitalWrite(IN_4, LOW);
  analogWrite(ENB, speedCar);
}

void goRight() { 
  digitalWrite(IN_1, LOW);
  digitalWrite(IN_2, HIGH);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, LOW);
  digitalWrite(IN_4, HIGH);
  analogWrite(ENB, speedCar);
}

void goLeft() {
  digitalWrite(IN_1, HIGH);
  digitalWrite(IN_2, LOW);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, HIGH);
  digitalWrite(IN_4, LOW);
  analogWrite(ENB, speedCar);
}

void goForwardRight() { 
  digitalWrite(IN_1, HIGH);
  digitalWrite(IN_2, LOW);
  analogWrite(ENA, speedCar-speed_low);
  
  digitalWrite(IN_3, LOW);
  digitalWrite(IN_4, HIGH);
  analogWrite(ENB, speedCar);
}

void goForwardLeft() {
  digitalWrite(IN_1, HIGH);
  digitalWrite(IN_2, LOW);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, LOW);
  digitalWrite(IN_4, HIGH);
  analogWrite(ENB, speedCar-speed_low);
}

void goBackRight() { 
  digitalWrite(IN_1, LOW);
  digitalWrite(IN_2, HIGH);
  analogWrite(ENA, speedCar-speed_low);
  
  digitalWrite(IN_3, HIGH);
  digitalWrite(IN_4, LOW);
  analogWrite(ENB, speedCar);
}

void goBackLeft() { 
  digitalWrite(IN_1, LOW);
  digitalWrite(IN_2, HIGH);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, HIGH);
  digitalWrite(IN_4, LOW);
  analogWrite(ENB, speedCar-speed_low);
}

void stopRobot() {  
  digitalWrite(IN_1, LOW);
  digitalWrite(IN_2, LOW);
  analogWrite(ENA, speedCar);
  
  digitalWrite(IN_3, LOW);
  digitalWrite(IN_4, LOW);
  analogWrite(ENB, speedCar);
}
