import RPi.GPIO as GPIO
from time import sleep
from dataTransmission import data_transmission

GPIO.setmode(GPIO.BCM)
GPIO.setup(25, GPIO.OUT)
GPIO.setup(24, GPIO.IN)

open = '0'

try:
    while True:
        if GPIO.input(24) == GPIO.HIGH:
            GPIO.output(25, GPIO.HIGH)
            open =  '1'
        else:
            GPIO.output(25, GPIO.LOW)
            open = '0'
        data_transmission(open)
        sleep(0.01)
except KeyboardInterrupt:
    pass

GPIO.cleanup()
