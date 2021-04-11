m = peripheral.find("monitor")
 
if not m then 
    term.clear()
    term.setCursorPos(1,1)
    error("You must connect a 3x2 wide monitor.")
end
 
m.setTextScale(1)
 
function fullClear()
    m.clear()
    m.setCursorPos(1,1)
end
 
function fullClearComputer()
    term.clear()
    term.setCursorPos(1,1)
end
 
function newLine(count)
    x,y = m.getCursorPos()
    m.setCursorPos(1,y+count)
end
 
function newLineComputer(count)
    x,y = term.getCursorPos()
    term.setCursorPos(1,y+count)
end
 
function wr(str)
    m.write(str)
    newLine(1)
end
 
function drawTitle()
    local x, _ = m.getSize()
    fullClear()
    m.write("Rocket API v1.0")
    m.setCursorPos(x-9,1)
    m.write("by sd31117")
    newLine(2)
end
 
function noteBlockOutput(count)
    for i=1,count do
        redstone.setOutput(sides[3], true)
        os.sleep(0.2)
        redstone.setOutput(sides[3], false)
        os.sleep(0.2)
    end
end
 
function drawLoader()
    local x, y = m.getCursorPos()
        if not firstLoop then x = 1 end
        m.setCursorPos(x,y)
        m.write("|")
        os.sleep(0.1)
        m.setCursorPos(x, y)
        m.write("/")
        os.sleep(0.1)
        m.setCursorPos(x, y)
        m.write("-")
        os.sleep(0.1)
        m.setCursorPos(x, y)
        m.write("\\")
        os.sleep(0.1)
        firstLoop = false
end
 
function centerText(text)
    local x,y = m.getSize()
    local x2,y2 = m.getCursorPos()
    m.setCursorPos(math.ceil((x / 2) - (text:len() / 2)), y2)
    m.write(text)
end
 
function takeoff()
    fullClear()
    m.setTextScale(3)
    centerText("PREPARE")
    newLine(1)
    os.sleep(0.5)
    centerText("FOR")
    newLine(1)
    os.sleep(0.5)
    centerText("TAKEOFF")
    newLine(1)
    os.sleep(2)
    fullClear()
    m.setTextScale(5)
    centerText("10")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("9")
    os.sleep(1)
    noteBlockOutput(1)
    fullClear()
    centerText("8")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("7")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("6")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("5")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("4")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("3")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("2")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    centerText("1")
    noteBlockOutput(1)
    os.sleep(1)
    fullClear()
    m.setTextScale(3)
    centerText("Enjoy")
    newLine(1)
    centerText("your")
    newLine(1)
    centerText("Flight!")
    redstone.setOutput(sides[1], true)
    os.sleep(2)
    redstone.setOutput(sides[1], false)
end
 
fullClearComputer()
print("Rocket API Setup")
print("l = left, r = right, b = back, f = front, t = top, bt = bottom")
 
write("Side for Launch Controller: ")
controllerSide = read()
 
write("Side for button/redstone: ")
redSide = read()
 
write("Side for noteblock (optional): ")
noteSide = read()
 
if noteSide ~= nil then sides = {controllerSide, redSide, noteSide}
else sides = {controllerSide, redSide} end
 
for i=1,#sides do
    if sides[i] == "l" then sides[i] = "left" end
    if sides[i] == "r" then sides[i] = "right" end
    if sides[i] == "f" then sides[i] = "front" end
    if sides[i] == "b" then sides[i] = "back" end
    if sides[i] == "t" then sides[i] = "top" end
    if sides[i] == "bt" then sides[i] = "bottom" end
end
 
newLineComputer(1)
print("Successfully configured.")
print("Launch Controller side = " .. sides[1])
print("Button/Signal side = " .. sides[2])
if sides[3] ~= nil then
    print("Note Block side = " .. sides[3])
end
newLineComputer(1)
print("Please refer to instructions on monitor.")
 
drawTitle()
wr("Welcome to Rocket API v1.0.")
newLine(1)
wr("Please place a button or")
wr("live redstone source on the") 
wr(sides[2] .. " side of the computer.")
wr("(LaunchController RS to " .. sides[1] ..")")
newLine(1)
wr("Waiting for redstone input...")
while not redstone.getInput(sides[2]) do
    drawLoader()
end
primed = true
 
while primed do
    m.setTextScale(1)
    m.clear()
    drawTitle()
    os.sleep(0.2)
    if sides[3] ~= nil then
        noteBlockOutput(3)
    end
    wr("Redstone signal recognized.")
    wr("System is now primed.")
    newLine(1)
    wr("Please place your rocket on")
    wr("the launch pad and re-click")
    wr("button to blast off!")
    while not redstone.getInput(sides[2]) do
        drawLoader()
    end
    takeoff()
end