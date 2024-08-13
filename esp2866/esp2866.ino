#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif

#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <ArduinoJson.h>

/* WiFi credentials */
#define WIFI_SSID "flutter"        // WiFi SSID
#define WIFI_PASSWORD "flutter123" // WiFi password

/* Firebase configuration */
#define API_KEY "AIzaSyA40kf45kSfEkb41qnj9GfPVkoCyLQlW8o"
#define FIREBASE_PROJECT_ID "iot-and-flutter-e5b97"
#define USER_EMAIL "siam@gmail.com"
#define USER_PASSWORD "123456789"

/* LED pin definitions */
#define FAN_PIN D0
#define LED_GREEN_PIN D1
#define LED_RED_PIN D2
#define POTENTIOMETER A0

// Firebase data, authentication, and configuration objects
FirebaseData fbdo;     // Object to handle Firebase data
FirebaseAuth auth;     // Object for Firebase authentication
FirebaseConfig config; // Object for Firebase configuration

void setup()
{
  Serial.begin(115200);   // Start serial communication at 115200 baud rate
  connectToWiFi();        // Establish Wi-Fi connection
  configureFirebase();    // Initialize Firebase connection
  initializeLEDsAndFan(); // Set up LED pins
}

void loop()
{
  readPotentiometer();
  fetchAndUpdateLEDsAndFan(); // Update LED states based on Firebase data
  delay(100);
}

void connectToWiFi()
{
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); // Start Wi-Fi connection with SSID and password
  Serial.print("Connecting to Wi-Fi");  // Indicate connection attempt

  // Wait for Wi-Fi connection
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print("."); // Indicate progress with dots
    delay(300);        // Delay for 300 milliseconds
  }

  // Print local IP address upon successful connection
  Serial.println("\nConnected with IP: ");
  Serial.println(WiFi.localIP()); // Display local IP address
}

void configureFirebase()
{
  Serial.printf("Firebase Client v%s\n", FIREBASE_CLIENT_VERSION); // Print Firebase client version

  config.api_key = API_KEY;                           // Set API key
  auth.user.email = USER_EMAIL;                       // Set user email for authentication
  auth.user.password = USER_PASSWORD;                 // Set user password for authentication
  config.token_status_callback = tokenStatusCallback; // Set token callback function

  Firebase.begin(&config, &auth); // Initialize Firebase with configuration and authentication
  Firebase.reconnectWiFi(true);   // Enable automatic Wi-Fi reconnection for Firebase
}

void initializeLEDsAndFan()
{
  pinMode(FAN_PIN, OUTPUT);
  pinMode(LED_GREEN_PIN, OUTPUT);
  pinMode(LED_RED_PIN, OUTPUT);
  pinMode(POTENTIOMETER, INPUT);
}

void fetchAndUpdateLEDsAndFan()
{
  String path = "iot_control";       // Path to Firestore document
  Serial.print("Fetching data... "); // Indicate data fetching

  // Get the document from Firestore
  if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", path.c_str(), ""))
  {
    JsonDocument doc;                                                          // Create JSON document for data
    DeserializationError error = deserializeJson(doc, fbdo.payload().c_str()); // Deserialize JSON payload

    // Check for errors in JSON deserialization
    if (error)
    {
      Serial.print("deserializeJson() failed: "); // Print error message
      Serial.println(error.c_str());              // Print error details
      return;                                     // Exit function on error
    }

    controlLEDsBasedOnData(doc); // Update LED states based on fetched data
  }
}

void controlLEDsBasedOnData(JsonDocument &doc)
{
  JsonObject document = doc["documents"][0]; // Access the first document
  // Loop through each field in the document
  for (JsonPair field : document["fields"].as<JsonObject>())
  {
    const char *key = field.key().c_str();      // Get the field key (e.g., "fan", "green", "red")
    bool value = field.value()["booleanValue"]; // Get the boolean value

    // Print the field key and its value
    Serial.printf("%s: %s\n", key, value ? "true" : "false");
    Serial.println("--------------------------------------------");

    // Control LEDs based on the field key
    switch (key[0])
    {
    case 'f':                       // If key starts with 'f'
      digitalWrite(FAN_PIN, value); // Control fan
      break;
    case 'g':                             // If key starts with 'g'
      digitalWrite(LED_GREEN_PIN, value); // Control green LED
      break;
    case 'r':                           // If key starts with 'r'
      digitalWrite(LED_RED_PIN, value); // Control red LED
      break;
    default: // If key does not match any case
      break; // No action needed
    }
  }
}

void readPotentiometer()
{
  int analogValue = analogRead(POTENTIOMETER);
  int mappedValue = map(analogValue, 150, 1000, 0, 100);
  if (mappedValue < 0)
  {
    mappedValue = 0;
  }
  else if (mappedValue > 100)
  {
    mappedValue = 100;
  }

  String documentPath = "iot_control/potentiometer";

  // Update potentiometer value in Firestore
  updateFirestorePotentiometer(documentPath, mappedValue);
  Serial.print("Analog Value: ");
  Serial.println();
}
void updateFirestorePotentiometer(const String &documentPath, int newValue)
{
  FirebaseJson updateData;

  // Update the JSON structure with the new potentiometer value
  updateData.set("fields/potentiometer/integerValue", String(newValue));

  // Convert FirebaseJson to String
  String jsonStr;
  updateData.toString(jsonStr, true);

  // Update the document in Firestore
  if (Firebase.Firestore.patchDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), jsonStr.c_str(), ""))
  {

    Serial.println("Potentiometer value updated successfully.");
  }
  else
  {
    Serial.println("Failed to update potentiometer value:");
  }
}
