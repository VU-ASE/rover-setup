#!/usr/bin/python3

import os
import sys
import yaml
import hashlib
import argparse
import subprocess
import time

config_file = '/home/debix/rover.yaml'

SYS_CTL = '/usr/bin/systemctl'
ENV_FILE = '/opt/ase.env'
ENV_FILE_DEFINITION = """
ASE_SYSMAN_SERVER_ADDRESS=tcp://localhost:1337
ASE_SYSMAN_BROADCAST_ADDRESS=tcp://localhost:1338
ASE_LOG_FILE=/home/debix/logs/logs
"""


SERVICE_DIR = '/etc/systemd/system/'
SERVICE_TEMPLATE = """
[Unit]
Description=%s
PartOf=rover.target

[Service]
Type=simple
User=debix
Group=debix
EnvironmentFile=/opt/ase.env
WorkingDirectory=/home/debix/
ExecStart=%s
ExecStartPost=/home/debix/ase/bin/servicedead
Restart=always
RestartSec=3
StartLimitInterval=0
StartLimitBurst=5
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
"""

ROVER_TARGET = 'rover.target'
ROVER_TARGET_PATH = SERVICE_DIR + ROVER_TARGET
ROVER_TARGET_TEMPLATE = """
[Unit]
Description=ASE rover utility group
Documentation=https://docs.ase.vu.nl
Wants=%s


[Install]
WantedBy=multi-user.target
"""


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
    
        
def wait_for_button_press():
    # Make sure that the button is not held when the function is called
    while button_pressed():
        time.sleep(0.1)
    
    odd = True
    # count how many iterations the button is held
    iterations_held = 0
    
    while True:
        if odd and iterations_held < 2:
            # set all LEDs to off 
            turn_off_leds()
        else:
             # turn on the red led
            turn_on_led(0)
            if iterations_held > 20:
                # turn on the orange led permanently
                turn_on_led(1)
            if iterations_held > 30:
                # turn on the green led permanently
                turn_on_led(2)
            if iterations_held > 40:
                # turn on the blue led permanently
                turn_on_led(3)
                
        with open(gpiopath) as f:
            s = f.read()
            
            if "1" in s:
                iterations_held += 1
            elif iterations_held < 50:
                iterations_held = 0
            else:
                return
        
        odd = not odd
        time.sleep(0.05)
        
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

def confirm_startup():
    try:
        initialize_gpio()
        # Set the buzzer to off
        buzzer_off()
        selected = select_program()
        notify_program_selected(selected)
        wait_for_button_press()        
        # set all LEDs to off 
        turn_off_leds()
        buzzer_countdown()
        return selected
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


def string_hash(some_string):
    return hashlib.sha256(some_string.encode()).hexdigest()


def file_hash(file_name):
    with open(file_name, 'r') as file:
        file_as_string = file.read()
    return string_hash(file_as_string)


def update_target(wants):
    target_definition = ROVER_TARGET_TEMPLATE % wants
    if os.path.exists(ROVER_TARGET_PATH):
        if file_hash(ROVER_TARGET_PATH) != string_hash(target_definition):
            with open(ROVER_TARGET_PATH, 'w') as file:
                file.write(target_definition)
    else:
        with open(ROVER_TARGET_PATH, 'w') as file:
            file.write(target_definition)



def check_env_file():
    with open(ENV_FILE, 'w') as file:
        file.write(ENV_FILE_DEFINITION)



def get_existing_services():
    existing_services = set()
    # read files in service dir and put contents into a set
    directory = os.fsencode(SERVICE_DIR)
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if filename.startswith("ase-") and filename.endswith(".service"):
            with open(SERVICE_DIR + filename, 'r') as file:
                existing_services.add(file.read())
    return existing_services


def cmd_start():
    global loaded_config, args

    existing_services = get_existing_services()
    loaded_services = set()

    loaded_wants = ""

    # put data from rover.yaml into a service file and store as string into set
    for module in loaded_config:
        filename = 'ase-' + module['name'].replace(' ', '-').lower() + '.service'
        loaded_wants += filename + " "
        service = SERVICE_TEMPLATE % (module['name'], module['cmd'])
        loaded_services.add(service)


    if existing_services != loaded_services:
        print("🟡 updating services")

        # stop existing services
        subprocess.run([SYS_CTL, 'stop', ROVER_TARGET, '-q'])

        # remove existing service files and symlinks
        directory = os.fsencode(SERVICE_DIR)
        for file in os.listdir(directory):
            filename = os.fsdecode(file)
            if filename.startswith("ase-") and filename.endswith(".service"):
                print(f"removing: {filename}")
                try:
                    os.remove(f"{SERVICE_DIR}{filename}")
                except Exception as e:
                    print(e)

        # create new service files and symlinks
        for module in loaded_config:
            filename = 'ase-' + module['name'].replace(' ', '-').lower() + '.service'
            service = SERVICE_TEMPLATE % (module['name'], module['cmd'])
            with open(f"{SERVICE_DIR}{filename}", 'w') as file:
                print(f"adding: {filename}")
                file.write(service)

        update_target(loaded_wants)
        subprocess.run([SYS_CTL, 'daemon-reload', '-q'])
        subprocess.run([SYS_CTL, 'start', ROVER_TARGET, '-q'])

    else:
        
        update_target(loaded_wants)
        subprocess.run([SYS_CTL, 'daemon-reload', '-q'])
        subprocess.run([SYS_CTL, 'start', ROVER_TARGET, '-q'])

    print(f"🟢 applied configuration from {config_file}")



def cmd_stop():
    subprocess.run([SYS_CTL, 'stop', ROVER_TARGET, '-q'])
    print("🔴 stopped rover")


def cmd_enable():
    cmd_start()
    subprocess.run([SYS_CTL, 'enable', ROVER_TARGET, '-q'])
    print("🟢 enabled rover")


def cmd_disable():
    subprocess.run([SYS_CTL, 'stop', ROVER_TARGET, '-q'])
    print("🔴 disabled rover")


def cmd_restart():
    cmd_start()
    subprocess.run([SYS_CTL, 'restart', ROVER_TARGET, '-q'])
    print(f"🟢 restarted rover")


def cmd_status():
    global watch_service
    directory = os.fsencode(SERVICE_DIR)
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if filename.startswith("ase-") and filename.endswith(".service"):
            result = subprocess.run([SYS_CTL, 'status', filename[:-8], '-q'], stdout=subprocess.PIPE).stdout.decode('utf-8')
            print(f"\n🟡 status: \n{result}\n")

    result = subprocess.run([SYS_CTL, 'status', ROVER_TARGET, '-q'], stdout=subprocess.PIPE).stdout.decode('utf-8')
    print(f"\n🟡 status: \n{result}\n")


def cmd_watch():
    global watch_service
    available_services = []
    directory = os.fsencode(SERVICE_DIR)
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if filename.startswith("ase-") and filename.endswith(".service"):
            available_services.append(filename[:-8])

    if watch_service not in available_services:
        print(f"🔴 no such service '{watch_service}'")
        print("   available services:\n")
        for service in available_services:
            print(f"      {service}")
        print("")
        exit(1)

    command = ["journalctl", "-u", watch_service, "-f"]
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    for line in iter(process.stdout.readline, b''):
        print(line.decode('utf-8'), end='', flush=True)

    process.wait()


def setup_args():
    global parser
    parser = argparse.ArgumentParser(description="""
    Manage the rover with one idempotent command. Reads a "rover.yaml" file in the home directory where you specify which programs to run. Simply use the "rover [start/stop]" commands to start or stop all commands. Using "rover [enable/disable]" is the same as start/stop, however it will make sure all of the programs stay running even if they crash and start on boot.
    """)

    parser.add_argument('-f', help='Optionally specify custom file path, default is /home/debix/rover.yaml', default=config_file, dest='file')
    parser.add_argument('-y', help='Disable button confirmation', default=False, dest='disableconfirm')

    subparsers = parser.add_subparsers(dest='command')

    parser_start = subparsers.add_parser('start', help='Start all services. If there is a different previous configuration, it will be stopped and the new one will be started.')
    parser_start.set_defaults(func=cmd_start)
    parser_start.add_argument('-y', help='Disable button confirmation', default=False, dest='disableconfirm', action='store_true')

    parser_stop = subparsers.add_parser('stop', help='Stop all services.')
    parser_stop.set_defaults(func=cmd_stop)

    parser_watch = subparsers.add_parser('watch', help='Watch the live stdout of a service, especially useful for debugging!')
    parser_watch.set_defaults(func=cmd_watch)
    parser_watch.add_argument('service', help='Name of the service to watch.')

    parser_restart = subparsers.add_parser('restart', help='Restart all currently loaded services.')
    parser_restart.set_defaults(func=cmd_restart)
    parser_restart.add_argument('-y', help='Disable button confirmation', default=False, dest='disableconfirm', action='store_true')

    parser_enable = subparsers.add_parser('enable', help='Start all services as daemons, will persist upon restart. If there is a previous configuration it will be disabled and the new one will be enabled.')
    parser_enable.set_defaults(func=cmd_enable)

    parser_disable = subparsers.add_parser('disable', help='Disable all service daemons.')
    parser_disable.set_defaults(func=cmd_disable)

    parser_status = subparsers.add_parser('status', help='View the status of the currently loaded services.')
    parser_status.set_defaults(func=cmd_status)

    return parser.parse_args()



def check_user():
    if not os.geteuid() == 0:
        sys.exit("\nUtility must be run as root, with sudo\n")

ACCEPTABLE_KEYS = ['name', 'cmd']

def validate_config(loaded_config):
    for module in loaded_config:
        for key in module.keys():
            if key not in ACCEPTABLE_KEYS:
                raise ValueError(f"YAML error: unrecognized key '{key}'")
            if not key:
                raise ValueError(f"YAML error: found an empty key")


def setup_config_file(args):
    global parser, config_file
    if not args.command:
        parser.print_help()
        exit(1)

    if args.file:
        config_file = args.file
        
    if not args.disableconfirm:
        print("🟡 press the button to confirm startup")
        selected_config = confirm_startup()
        if selected_config == 0:
            print("Selected program: 0")
        elif selected_config == 1:
            print("Selected program: 1")
            config_file = '/home/debix/rover1.yaml'
        elif selected_config == 2:
            print("Selected program: 2")
            config_file = '/home/debix/rover2.yaml'
    else:
        print("Selected program: 0")

    try:
        with open(config_file, 'r') as file:
            loaded_config = yaml.safe_load(file)

            validate_config(loaded_config)
            return loaded_config
    except Exception as e:
        print(f"Error: '{e}'")
        exit(1)

check_user()
check_env_file()

args = setup_args()
loaded_config = setup_config_file(args)


if args.command == 'watch':
    watch_service = args.service

args.func()


