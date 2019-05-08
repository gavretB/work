#define BAUDRATE 9600
#define FREQUENCY 923.0
#define SPREADFACTOR 7
#define BANDWIDTH 500000
#define CODINGRATE 8
#define CLIENT_ID 2

// library
#include <SPI.h>
#include <RH_RF95.h>
#include <time.h>
RH_RF95 rf95;

// global
uint16_t crcdata = 0;
uint16_t recCRCData = 0;
uint16_t cnt;
uint32_t time_s = 0;
uint32_t time_f = 0;

void setup() {
  Serial.begin(BAUDRATE);
  while (!Serial) ;
  if (!rf95.init())
    Serial.println("init failed");
  Serial.println();
  Serial.println("Initial Configration");
  Serial.print("  Client_ID: ");
  Serial.println(CLIENT_ID);
  Serial.print("  Baudrate: ");
  Serial.println(BAUDRATE);
  rf95.setFrequency(FREQUENCY);
  Serial.print("  Frequency: ");
  Serial.println(FREQUENCY);
  rf95.setSpreadingFactor(SPREADFACTOR);
  Serial.print("  Spread Factor: ");
  Serial.println(SPREADFACTOR);
  rf95.setSignalBandwidth(BANDWIDTH);
  Serial.print("  Band Width: ");
  Serial.println(BANDWIDTH);
  rf95.setCodingRate4(CODINGRATE);
  Serial.print("  Coding Rate: ");
  Serial.println(CODINGRATE);
  cnt = 0;
  Serial.println();
  Serial.print("Start LoRa Client ");
  Serial.println(CLIENT_ID);
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

uint16_t CRC16(uint8_t *pBuffer, uint32_t length)
{
    uint16_t wCRC16 = 0;
    uint32_t i;
    if (( pBuffer == 0 ) || ( length == 0 ))
    {
        return 0;
    }
    for ( i = 0; i < length; i++)
    {
        wCRC16 = calcByte(wCRC16, pBuffer[i]);
    }
    return wCRC16;
}

uint16_t recdata( unsigned char* recbuf, int Length)
{
    crcdata = CRC16(recbuf, Length - 2); //Get CRC code
    recCRCData = recbuf[Length - 1]; //Calculate CRC Data
    recCRCData = recCRCData << 8; //
    recCRCData |= recbuf[Length - 2];
}

void loop()
{
  if (rf95.waitAvailableTimeout (5000))
  {
    uint8_t buf[RH_RF95_MAX_MESSAGE_LEN];
    uint8_t len = sizeof(buf);
    if (rf95.recv(buf, &len))
    {
      recdata(buf, len);
      if(crcdata == recCRCData)
      {          
        cnt++;
        if (cnt%50 == 0)
        {
          time_s = time_f;
          time_f = micros();
          Serial.print(" Receive: ");
          Serial.print(cnt);
          Serial.print(" time(us): ");
          Serial.print(time_f);
          Serial.print(" dif(us): ");
          Serial.print(time_f - time_s);
          Serial.print(" rssi(db): ");
          Serial.println(rf95.lastRssi(), DEC);
          //Serial.print(" snr(%): ");
          //Serial.println(rf95.lastSNR(), DEC);
        }else if (cnt%10 == 0)
        {
          Serial.println(" Receiveing... ");
        }else
        {
        }
      }else
      {
      }
    }else
    {
    }
  }else
  {       
  }
}
