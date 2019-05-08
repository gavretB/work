#define BAUDRATE 9600
#define FREQUENCY 923.0
#define SPREADFACTOR 7
#define TXPOWER 13
#define BANDWIDTH 500000
#define CODINGRATE 8
#define PAYLOAD_SIZE 50
#define DATA_SIZE 1536
#define CLIENT_ID 1

// library
#include <SPI.h>
#include <RH_RF95.h>
#include <time.h>
RH_RF95 rf95;

// global
uint8_t data[RH_RF95_MAX_MESSAGE_LEN] = {0};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(BAUDRATE);
  while (!Serial) ;
  if (!rf95.init())
    Serial.println("init failed");
  Serial.println();
  Serial.println("Initial Configration");
  Serial.print("  Client_ID: ");
  Serial.println(CLIENT_ID);
  //Serial.println("setModeTx");
  //rf95.setModeTx();
  Serial.print("  Baudrate: ");
  Serial.println(BAUDRATE);
  rf95.setFrequency(FREQUENCY);
  Serial.print("  Frequency: ");
  Serial.println(FREQUENCY);
  rf95.setTxPower(TXPOWER);
  Serial.print("  Tx Power: ");
  Serial.println(TXPOWER);
  rf95.setSpreadingFactor(SPREADFACTOR);
  Serial.print("  Spread Factor: ");
  Serial.println(SPREADFACTOR);
  rf95.setSignalBandwidth(BANDWIDTH);
  Serial.print("  Band Width: ");
  Serial.println(BANDWIDTH);
  rf95.setCodingRate4(CODINGRATE);
  Serial.print("  Coding Rate: ");
  Serial.println(CODINGRATE);
  data[0] = CLIENT_ID;
  Serial.println();
  Serial.println("Start LoRa Client");
  Serial.println();
}

uint16_t calcByte(uint16_t crc, uint8_t b)
{
    uint32_t i;
    crc = crc ^ (uint32_t)b << 8;
    
    for ( i = 0; i < 8; i++)
    {
        if ((crc & 0x8000) == 0x8000)
            crc = crc << 1 ^ 0x1021;
        else
            crc = crc << 1;
    }
    return crc & 0xffff;
}

uint16_t CRC16(uint8_t *pBuffer,uint32_t length)
{
    uint16_t wCRC16=0;
    uint32_t i;
    if (( pBuffer==0 )||( length==0 ))
    {
      return 0;
    }
    for ( i = 0; i < length; i++)
    { 
      wCRC16 = calcByte(wCRC16, pBuffer[i]);
    }
    return wCRC16;
}

void loop()
{
  for (uint8_t i = 1; i < PAYLOAD_SIZE; i++)
  {
    srand((unsigned int)time(NULL)); // initialize of rand value
    data[i] = rand() % 255 + 1;
  }
  
  uint16_t crcData = CRC16((unsigned char*)data, PAYLOAD_SIZE);
  
  data[PAYLOAD_SIZE] = (unsigned char)crcData;
  data[PAYLOAD_SIZE+1] = (unsigned char)(crcData>>8);
  
  rf95.send(data, PAYLOAD_SIZE+2);
}
