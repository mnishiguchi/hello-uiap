// UIAPduino Pro Micro CH32V003 V1.4 built-in orange LED.
#define LED_BUILTIN 2

void setup() {
  // Let reset alternate between running and USB write-standby modes.
  if (FLASH->STATR & (1 << 14)) NVIC_SystemReset();
  SystemReset_StartMode(Start_Mode_BOOT);
  pinMode(PD4, OUTPUT);

  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);
  digitalWrite(LED_BUILTIN, LOW);
  delay(250);
}
