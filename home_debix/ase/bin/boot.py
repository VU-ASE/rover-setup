#!/usr/bin/python3

import os
import yaml
import time
import shutil
import requests

gpiopath = '/sys/class/gpio/gpio13/value'

#
# PCA5555 (GPIO extender over i2c)
#
def initialize_gpio():
    for i in ["0x02 0xfe", "0x03 0x0f", "0x06 0xfe", "0x07 0x0f"]:
        os.system("i2cset -y 5 0x21 " + i)
    
# Index is a number between 0 and 3 (inclusive)
def turn_on_led(index):
    if index > 3 or index < 0:
        return

    if index == 0:
        # turn on the red led
        os.system("i2cset -y 5 0x21 0x03 0x80")
    elif index == 1:
        # turn on the orange led 
        os.system("i2cset -y 5 0x21 0x03 0x40")
    elif index == 2:
        # turn on the green led
        os.system("i2cset -y 5 0x21 0x03 0x20")
    elif index == 3:
        # turn on the blue led
        os.system("i2cset -y 5 0x21 0x03 0x10")
        
# turns off all LEDs
def turn_off_leds():
    os.system("i2cset -y 5 0x21 0x03 0x00")
    
def buzzer_on():
    os.system("i2cset -y 5 0x21 0x02 0x01")
    
def buzzer_off():
    os.system("i2cset -y 5 0x21 0x02 0x00")
    
def button_pressed():    
    with open(gpiopath) as f:
        s = f.read()
        
        if "1" in s:
            return True
        else:
            return False
    
# This function returns a 0, 1 or 2 (depending on the item cycled through)
# this can be useful to select the program to run
def select_program():
    selected_program = 0
    
    # We want not to cycle during holding the button
    # one press should cycle to the next program
    button_held_iterations = 0
    
    odd = True
    while True:
        # blink the red light continuously
        if odd:
            turn_off_leds()
        else:
            turn_on_led(0)
            
        pressed = button_pressed()
        if pressed and button_held_iterations < 20:
            button_held_iterations += 1
        elif pressed and button_held_iterations >= 20:
            return selected_program
        elif not pressed and button_held_iterations > 0 and button_held_iterations < 20:
            selected_program = (selected_program + 1) % 3
            button_held_iterations = 0
        elif not pressed:
            button_held_iterations = 0
            
        if selected_program == 0:
            # blink the orange light
            turn_on_led(1)
        elif selected_program == 1:
            # blink the green light
            turn_on_led(2)
        elif selected_program == 2:
            # blink the blue light
            turn_on_led(3)
            
        odd = not odd
            
        time.sleep(0.1)

def notify_program_selected(selected_program):
    iterations = selected_program + 1
    for i in range(iterations):
        buzzer_off()
        buzzer_on()
        time.sleep(0.5)
        buzzer_off()
        time.sleep(0.2)
  
def buzzer_countdown():
    buzzer_off()
    buzzer_on()
    time.sleep(0.25)
    buzzer_off()
    time.sleep(2)
    buzzer_on()
    time.sleep(0.2)
    buzzer_off()
    time.sleep(2)
    buzzer_on()
    time.sleep(0.1)
    buzzer_off()
    time.sleep(1)
    
def buzzer_alarm():
    while True:
        buzzer_on()
        time.sleep(0.05)
        buzzer_off()
        time.sleep(0.1)
        buzzer_on()
        time.sleep(0.2)
        buzzer_off()
        time.sleep(0.1)

def startup():
    try:
        initialize_gpio()
        # Set the buzzer to off
        buzzer_off()

        try:
            with open("/home/debix/race.yaml", "r") as file:
                data = yaml.safe_load(file)
        except FileNotFoundError:
            print("race.yaml was not found. Make sure it is in the /home/debix/ repository!")
            try:
                buzzer_alarm()
            except KeyboardInterrupt:
                print("Exiting")
                buzzer_off()
                buzzer_off()
                return
        
        print("race.yaml found. Select your profile")

        # Determine profile selection
        selected = select_program()
        notify_program_selected(selected)
        turn_off_leds()
        
        print(f"Program selected: {selected + 1}")


        pipeline = data.get("pipeline", [])
        profiles = ["profile1.yaml", "profile2.yaml", "profile3.yaml"]

        if not pipeline:
            print("Error parsing race.yaml, did you add your pipeline")
            try:
                buzzer_alarm()
            except KeyboardInterrupt:
                print("Exiting")
                buzzer_off()
                buzzer_off()
                return
            
        print(f"Your pipeline: {pipeline}")

        payload = []
        profile = profiles[selected]
        profile_path = ""

        for part in pipeline:
            details = part.split("/")

            payload.append({
               "fq": {
                   "author": details[0],
                   "name": details[1],
                   "version": details[2]
               } 
            })

            # If this is the controller service, use this for setting the profile
            if details[1] == "controller":
                profile_path = f"/home/debix/.rover/{details[0]}/controller/{details[2]}/{profile}"
        
        print(f"Payload: {payload}")

        if profile_path == "":
            print("Did not find a service named \"controller\" to use to set profile")
            try:
                buzzer_alarm()
            except KeyboardInterrupt:
                print("Exiting")
                buzzer_off()
                buzzer_off()
                return


        print(f"Selected profile: {profile}")

        # Create a destination path, which is the service.yaml in the same directory.
        dest, _ = profile_path.rsplit("/", 1)
        dest += "/service.yaml"
        print(profile_path)
        print(dest)

        if not os.path.exists(profile_path):
            print("Profile path does not exist")
            try:
                buzzer_alarm()
            except KeyboardInterrupt:
                print("Exiting")
                buzzer_off()
                buzzer_off()
                return
        
        # Copy
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        shutil.copy2(profile_path, dest)

        # Set a pipeline
        response = requests.post(
            url="http://localhost/pipeline",
            json=payload,
            auth=("debix", "debix")
        )

        print(f"Status code: {response}")
        
        buzzer_countdown()

        # Start the pipeline
        response = requests.post(
            url='http://localhost/pipeline/start',
            auth=('debix', 'debix')
        )

        text = response.text  
        headers = response.headers  
        status_code = response.status_code  

        print(f"Status Code: {status_code}")
        print(f"Headers: {headers}")
        print(f"Text: {text[:500]}") 

        return
    except KeyboardInterrupt:
        print("Exiting")
        # set all LEDs to off 
        turn_off_leds()
        # Turn off the buzzer
        buzzer_off()
    except Exception as e:
        print("An error occured: " + str(e))
        turn_off_leds()
        try:
            buzzer_alarm()
        except KeyboardInterrupt:
            print("Exiting")
            buzzer_off()
            buzzer_off()

startup()
