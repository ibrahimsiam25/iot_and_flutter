#if defined(ESP32)
#include <WiFi.h> // Include WiFi library for ESP32
#elif defined(ESP8266)
#include <ESP8266WiFi.h> // Include WiFi library for ESP8266
#endif

#include <Firebase_ESP_Client.h> // Include Firebase client library
#include <addons/TokenHelper.h> // Include token helper for authentication
#include <ArduinoJson.h> // Include Arduino JSON library

/* WiFi credentials */
#define WIFI_SSID "flutter" // WiFi SSID
#define WIFI_PASSWORD "flutter123" // WiFi password

/* Firebase configuration */
#define API_KEY "AIzaSyA40kf45kSfEkb41qnj9GfPVkoCyLQlW8o" // Firebase API key
#define FIREBASE_PROJECT_ID "iot-and-flutter-e5b97" // Firebase project ID
#define USER_EMAIL "siam@gmail.com" // User email for Firebase authentication
#define USER_PASSWORD "123456789" // User password for Firebase authentication

/* LED pin definitions */
#define FAN_PIN D0 // Pin for fan control
#define LED_GREEN_PIN D1 // Pin for green LED control
#define LED_RED_PIN D2 // Pin for red LED control

// Firebase data, authentication, and configuration objects
FirebaseData fbdo; // Object to handle Firebase data
FirebaseAuth auth; // Object for Firebase authentication
FirebaseConfig config; // Object for Firebase configuration

void setup() {
  Serial.begin(115200); // Start serial communication at 115200 baud rate
  connectToWiFi(); // Establish Wi-Fi connection
  configureFirebase(); // Initialize Firebase connection
  initializeLEDsAndFan(); // Set up LED pins
}

void loop() {
  fetchAndUpdateLEDsAndFan(); // Update LED states based on Firebase data
  delay(100); // Pause for 1 second before next iteration
}

void connectToWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); // Start Wi-Fi connection with SSID and password
  Serial.print("Connecting to Wi-Fi"); // Indicate connection attempt
  
  // Wait for Wi-Fi connection
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print("."); // Indicate progress with dots
    delay(300); // Delay for 300 milliseconds
  }

  // Print local IP address upon successful connection
  Serial.println("\nConnected with IP: ");
  Serial.println(WiFi.localIP()); // Display local IP address
}

void configureFirebase() {
  Serial.printf("Firebase Client v%s\n", FIREBASE_CLIENT_VERSION); // Print Firebase client version
  
  config.api_key = API_KEY; // Set API key
  auth.user.email = USER_EMAIL; // Set user email for authentication
  auth.user.password = USER_PASSWORD; // Set user password for authentication
  config.token_status_callback = tokenStatusCallback; // Set token callback function

  Firebase.begin(&config, &auth); // Initialize Firebase with configuration and authentication
  Firebase.reconnectWiFi(true); // Enable automatic Wi-Fi reconnection for Firebase
}

void initializeLEDsAndFan() {
  pinMode(FAN_PIN, OUTPUT); // Set fan control pin as output
  pinMode(LED_GREEN_PIN, OUTPUT); // Set green LED pin as output
  pinMode(LED_RED_PIN, OUTPUT); // Set red LED pin as output
}

void fetchAndUpdateLEDsAndFan() {
  String path = "iot_control"; // Path to Firestore document
  Serial.print("Fetching data... "); // Indicate data fetching

  // Get the document from Firestore
  if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", path.c_str(), "")) {
    JsonDocument doc; // Create JSON document for data
    DeserializationError error = deserializeJson(doc, fbdo.payload().c_str()); // Deserialize JSON payload

    // Check for errors in JSON deserialization
    if (error) {
      Serial.print("deserializeJson() failed: "); // Print error message
      Serial.println(error.c_str()); // Print error details
      return; // Exit function on error
    }

    controlLEDsBasedOnData(doc); // Update LED states based on fetched data
  }
}

void controlLEDsBasedOnData(JsonDocument& doc) {
  JsonObject document = doc["documents"][0]; // Access the first document
  // Loop through each field in the document
  for (JsonPair field : document["fields"].as<JsonObject>()) {
    const char* key = field.key().c_str(); // Get the field key (e.g., "fan", "green", "red")
    bool value = field.value()["booleanValue"]; // Get the boolean value

    // Print the field key and its value
    Serial.printf("%s: %s\n", key, value ? "true" : "false");
    Serial.println("--------------------------------------------");

    // Control LEDs based on the field key
    switch (key[0]) {
      case 'f': // If key starts with 'f'
        digitalWrite(FAN_PIN, value); // Control fan
        break;
      case 'g': // If key starts with 'g'
        digitalWrite(LED_GREEN_PIN, value); // Control green LED
        break;
      case 'r': // If key starts with 'r'
        digitalWrite(LED_RED_PIN, value); // Control red LED
        break;
      default: // If key does not match any case
        break; // No action needed
    }
  }
}