import sys
import win32api as api
import win32con as con
import time

try:
    api.SetConsoleTitle("Wiggle")
except Exception as e:
    print("Got exception %s - ignoring" % e)

iteration = 0
while True:
    sleepTime = 60
    print("%s  " % (sleepTime * iteration), end="", flush=True)
    api.mouse_event(con.MOUSEEVENTF_WHEEL, 0, 0, 0)
    time.sleep(sleepTime)
    iteration += 1


