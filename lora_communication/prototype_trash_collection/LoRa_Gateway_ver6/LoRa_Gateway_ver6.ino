#define BAUDRATE 115200
#define FREQUENCY 923.0
#define SPREADFACTOR 10
#define TXPOWER 13
#define BANDWIDTH 125000
#define CODINGRATE 5
#define QUEUE_SIZE 2
#define TR_RANGE 4
#define YELLOW_RASIO 2
#define DEVICE_ID 0

// library
#include <Console.h>
#include <SPI.h>
#include <RH_RF95.h>
RH_RF95 rf95;

// global
uint8_t queue_a[QUEUE_SIZE]; // for address
uint8_t queue_p[QUEUE_SIZE]; // for priority
uint8_t cnt_q; // count for queue
uint8_t address[3] = {0, 3, 4}; // address of each devices
unsigned long time_0 = 0;
unsigned long time_1 = 1;

void setup() {
  // put your setup code here, to run once:
  Bridge.begin(BAUDRATE);
  Console.begin();
  while (!Console) ; // Wait for console port to be available
  if (!rf95.init())
    Console.println("init failed");
  Console.println();
  Console.println("Initial Configration");
  Console.print("  Baudrate: ");
  Console.println(BAUDRATE);
  rf95.setFrequency(FREQUENCY);
  Console.print("  Frequency: ");
  Console.println(FREQUENCY);
  rf95.setTxPower(TXPOWER, useRFO = false);
  Console.print("  Tx Power: ");
  Console.println(TXPOWER);
  rf95.setSpreadingFactor(SPREADFACTOR);
  Console.print("  Spread Factor: ");
  Console.println(SPREADFACTOR);
  rf95.setSignalBandwidth(BANDWIDTH);
  Console.print("  Band Width: ");
  Console.println(BANDWIDTH);
  rf95.setCodingRate4(CODINGRATE);
  Console.print("  Coding Rate: ");
  Console.println(CODINGRATE);
  Console.println();
  Console.println("Start LoRa Gateway");
  Console.println();
}

void loop() 
{
  // send query
  uint8_t query[1] = {1};
  rf95.send(query, 1);
  rf95.waitPacketSent();
  Console.println();
  Console.println("Waiting ...");
  Console.println();
  if (rf95.waitAvailableTimeout(5000))
  {
    uint8_t buf[RH_RF95_MAX_MESSAGE_LEN];
    uint8_t len = sizeof(buf);
    if (rf95.recv(buf, &len))
    {
      switch (buf[0]) // classify
      {
        case 2:
                if (cnt_q < QUEUE_SIZE)
                {
                  // specify
                  uint8_t address_x = address[buf[1]]; // refer address
                  uint8_t address_0 = address[0];
                  if ((address_0 + TR_RANGE)/YELLOW_RASIO < address_x) // green
                  {
                    // ack
                    uint8_t ack[2] = {3, buf[1]};
                    rf95.send(ack, 2);
                    rf95.waitPacketSent();
                    // queueing
                    queue_a[cnt_q] = ack[1];
                    cnt_q++;
                    //print
                    Console.println();
                    Console.print("Queue: ");
                    for (uint8_t i = 0; i < QUEUE_SIZE; i++)
                    {
                      if (i == QUEUE_SIZE-1)
                      {
                        Console.println(queue_a[i]);
                      }
                      else
                      {
                        Console.print(queue_a[i]);
                        Console.print(" ");
                      }
                    }
                    if (cnt_q == QUEUE_SIZE) // Scheduling Phase
                    {
                      for (uint8_t i = 0; i < QUEUE_SIZE-1; i++)
                      {
                        for (uint8_t j = 0; queue_p[j-1] > queue_p[j]; j++)
                        {
                          uint8_t tmp_p = queue_p[j-1];
                          uint8_t tmp = queue_a[j-1];
                          queue_p[j-1] = queue_p[j];
                          queue_a[j-1] = queue_a[j];
                          queue_p[j] = tmp_p;
                          queue_a[j] = tmp;
                        }
                      }
                      uint8_t permit[2] = {4, queue_a[0]};
                      rf95.send(permit, 2);
                      rf95.waitPacketSent();
                      time_0 = micros();
                      Console.println();
                      Console.print("permition: ");
                      Console.println(permit[1]);
                      Console.println();
                      cnt_q = 0;
                      for (uint8_t i = 0; i < QUEUE_SIZE; i++)
                      {
                        queue_a[i] = 0;
                      }
                    }
                    else
                    {
                      ;
                    }
                  }
                  else // yellow or red
                  {
                    // reject[2] = {Signal_ID, Client_ID}
                    uint8_t reject[2] = {5, buf[1]};
                    rf95.send(reject, 2);
                    rf95.waitPacketSent();
                    // print
                    Console.println();
                    Console.print("reject: ");
                    Console.println(buf[1]);
                    if (address_x <= address_0) // red
                    {
                      Console.println("because of RED-area");
                      Console.println();
                    }
                    else // yellow
                    {
                      Console.println("because of YELLOW-area");
                      Console.println();
                    }
                  }
                }
                else
                {
                  ;
                }
                break;
        case 6:
                // ack[3] = {Signal_ID, Client_ID, Piece_ID}
                time_1 = micros();
                uint8_t ack[3] = {7, buf[1], buf[2]};
                rf95.send(ack, 3);
                // print piece
                Console.println();
                Console.println("Recv Piece");
                Console.print("  Client_ID: ");
                Console.println(ack[1]);
                Console.print("  Piece_ID: ");
                Console.println(ack[2]);
                Console.print("  Tx speed: ");
                Console.print(time_1 - time_0);
                Console.println(" microsec");
                Console.println();
                break;
        case 8:
                Console.println();
                Console.print("finish: ");
                Console.println(buf[1]);
                Console.println();
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
