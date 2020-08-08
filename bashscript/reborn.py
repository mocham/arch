import pyautogui
import sys
import time

short_period = .1
medium_period = .3

def check_reborn():
    px = list(pyautogui.screenshot(region=(1060,230,1,1)).getdata())[0]
    if px[0] == 233:
        return True
    else:
        return False

def check_button(which):
    if which == 4:
        px = list(pyautogui.screenshot(region=(380,510,1,1)).getdata())[0]
        if px[0] == 173:
            return True
        else:
            return False
    elif which == 3:
        px = list(pyautogui.screenshot(region=(160,510,1,1)).getdata())[0]
        if px[0] == 173:
            return True
        else:
            return False
    elif which == 2:
        px = list(pyautogui.screenshot(region=(380,390,1,1)).getdata())[0]
        if px[0] == 162:
            return True
        else:
            return False
    elif which == 1:
        px = list(pyautogui.screenshot(region=(160,390,1,1)).getdata())[0]
        if px[0] == 162:
            return True
        else:
            return False
    return False

def force_click(which):
    total = 1
    while not check_button(which):
        time.sleep(short_period)
        total += 1
        if total > 10:
            break
    click_button(which)
    time.sleep(short_period)

def click_button(which):
    if which == 4:
        pyautogui.click(380,510)
        time.sleep(short_period)
    elif which == 2:
        pyautogui.click(400,390)
        time.sleep(short_period)
    elif which == 3:
        pyautogui.click(160,510)
        time.sleep(short_period)
    elif which == 1:
        pyautogui.click(200,390)
        time.sleep(short_period)


def click_group(arr):
    for i in arr:
        if check_button(i):
            click_button(i)
            time.sleep(medium_period)
            time.sleep(medium_period)

def reborn_group(idx):
    pyautogui.click(1060, 230)
    time.sleep(short_period)
    while True:
        px = list(pyautogui.screenshot(region=(430,570,1,1)).getdata())[0]
        if px[0] == 215:
            break
        else:
            time.sleep(short_period)
    pyautogui.click(430, 570)
    print("########## %d ###########  Reborn clicked!"%idx)
    while True:
        px = list(pyautogui.screenshot(region=(560,500,1,1)).getdata())[0]
        if px[0] == 119:
            break
        else:
            time.sleep(short_period)
    pyautogui.click(560, 500)
    #time.sleep(5.5)
    #time.sleep(.5)
    #pyautogui.click(760, 210)
    #time.sleep(.5)

def full(idx):
    force_click(1)
    force_click(1)
    force_click(1)
    force_click(4)
    force_click(1)
    force_click(2)
    force_click(4)
    force_click(3)
    force_click(4)
    force_click(3)
    force_click(2)
    force_click(4)
    force_click(3)
    force_click(2)
    while not check_reborn():
        force_click(1)
        force_click(2)
    reborn_group(idx)

for idx in range(0, int(sys.argv[1])):
    full(idx)

