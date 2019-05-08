#define BAUDRATE 9600
#define FREQUENCY 923.0
#define SPREADFACTOR 10
#define TXPOWER 13
#define BANDWIDTH 125000
#define CODINGRATE 5
#define PIECE_SIZE 248
#define DATA_SIZE 1536
#define CLIENT_ID 1

// library
#include <SPI.h>
#include <RH_RF95.h>
#include <time.h>
RH_RF95 rf95;

// global
uint8_t ack_flag = 0;
uint8_t per_flag = 0;
uint8_t reject_flag = 0;
uint8_t cnt_p = 0;
uint8_t end_flag = 0;
uint8_t data[RH_RF95_MAX_MESSAGE_LEN] = {0};
//unsigned long t_start = 0;
//unsigned long t_stop = 0;

void setup() 
{
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
  data[0] = 6;
  data[1] = CLIENT_ID;
  Serial.println();
  Serial.println("Start LoRa Client");
  Serial.println();
}

void loop()
{
  if (ack_flag == 1 && per_flag == 1 && reject_flag == 0 && end_flag == 0)
  {
    data[2] = cnt_p;
    for (uint8_t i = 3; i < RH_RF95_MAX_MESSAGE_LEN; i++)
    {
      srand((unsigned int)time(NULL)); // initialize of rand value
      data[i] = rand() % 255 + 1;
    }
    //t_start = micros();
    rf95.send(data, RH_RF95_MAX_MESSAGE_LEN);
    rf95.waitPacketSent();
    /*t_stop = micros();
    Serial.println();
    Serial.println(t_stop-t_start);
    Serial.println();*/   
  }
  else
  {
    ;
  }
  
  if (rf95.waitAvailableTimeout(500))
  {
    uint8_t buf[RH_RF95_MAX_MESSAGE_LEN];
    uint8_t len = sizeof(buf);
    if (rf95.recv(buf, &len))
    {
      switch (buf[0]) // classify
      {
        case 1:
                if (ack_flag == 0  && per_flag == 0 && reject_flag == 0 && end_flag == 0)
                {
                  uint8_t request[2] = {2, CLIENT_ID};
                  rf95.send(request, 2);
                  rf95.waitPacketSent();
                }
                else
                {
                  ;
                }
                break;
        case 3:
                if (buf[1] == CLIENT_ID && ack_flag == 0 && per_flag == 0 && reject_flag == 0 && end_flag == 0)
                {
                  ack_flag = 1; 
                }
                else
                {
                  ;
                }
                break;
        case 4:
                if (buf[1] == CLIENT_ID && ack_flag == 1 && per_flag == 0 && reject_flag == 0 && end_flag == 0)
                {
                  per_flag = 1;
                }
                else
                {
                  ;
                }
                break;
        case 5:
                if (buf[1] == CLIENT_ID && reject_flag == 0 && end_flag == 0)
                {
                  reject_flag = 1;
                }
                else
                {
                  ;
                }
                break;
        case 7:
                if (buf[1] == CLIENT_ID && buf[2] == cnt_p && ack_flag == 1 && per_flag == 1 && reject_flag == 0 && end_flag == 0)
                {
                  if (DATA_SIZE/PIECE_SIZE + 1 == cnt_p)
                  {
                    uint8_t finish[2] = {8, CLIENT_ID};
                    rf95.send(finish, 2);
                    rf95.waitPacketSent();
                    end_flag = 1;
                  }
                  else
                  {
                    cnt_p = buf[2] + 1; 
                  }
                }
                else
                {
                  ;
                }
                break;
        default:
                break;
      }
    }
    else
    {
      ;
    }
  }
  else
  {
    ;
  }
}
