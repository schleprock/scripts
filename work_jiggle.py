#!/usr/bin/python
import sys
import ctypes
import win32api as api
import win32con as con
import win32gui as gui
import time
import bluetooth

AM, PM = 0, 12

WORK_START, WORK_END = 9 + AM, 7 + PM
#WORK_START, WORK_END = 9 + AM, 9 + AM  # never true
WORK_DAYS = [0, 1, 2, 3, 4] # Monday to Friday
PHONE = '64:BC:0C:F9:BC:08'
HEADSET = b"Headset Gateway\x00"
POLLING_INTERVAL = 60
MISSING_LIMIT = 15 # wait this many intervals before locking screen

DEBUG = False

def set_console_title(s):
    try:
        api.SetConsoleTitle(s)
    except Exception as e:
        print("Got exception %s in set_console_title('%s')- ignoring" % (e, s))

def callback(hwnd, lst):
    lst.append(gui.GetWindowText(hwnd))
    
def list_windows():
    lst = []
    gui.EnumWindows(callback, lst)
    print(lst)
    return lst

def is_screen_locked():
    try:
        fg = gui.GetForegroundWindow()
    except Exception as e:
        fg = 0
        print("Got exception %s in is_screen_locked()- ignoring" % e)
    return not fg

def is_screen_locked2():
    try:
        ci = gui.GetCursorInfo()
    except Exception as e:
        if DEBUG:
            print("Got exception %s in is_screen_locked2()- ignoring" % e)
        ci = None
    return ci is None
        
def lock_screen():
    ctypes.windll.user32.LockWorkStation()

def is_phone_present(phone, service=HEADSET):
    try:
        phone_present = len(bluetooth.find_service(address=phone, name=service))
    except Exception as e:
        phone_present = 0
        print("Got exception %s in is_phone_present() - ignoring" % e)
    return phone_present > 0

def in_work_hours(s):
    t = time.localtime(s)
    return WORK_START <= t.tm_hour < WORK_END and t.tm_wday in WORK_DAYS

def jiggle_mouse():
    api.mouse_event(con.MOUSEEVENTF_WHEEL, 0, 0, 0)

def main():
    set_console_title("jiggle")
    missing = 0
    while True:
        now = time.time()
        jiggle = False
        if not is_screen_locked():
            phone_present = is_phone_present(PHONE)
            if phone_present:
                missing = 0
            else:
                missing += 1        
            if in_work_hours(now) or missing < MISSING_LIMIT:
                jiggle = True
            elif not in_work_hours(now):
                # never force a lock during work hours
                ctypes.windll.user32.LockWorkStation()

        if jiggle:
            jiggle_mouse()
            
        #print("*" if phone_present else "." if jiggle else "-", end="", flush=True)

        elapsed = time.time() - now
        naptime = POLLING_INTERVAL - elapsed
        time.sleep(naptime if naptime > 1 else 1)

if __name__ == "__main__":
    main()
    
