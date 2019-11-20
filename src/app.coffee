# setup device for presentation
Framer.Device = new Framer.DeviceView();

Framer.Device.setupContext()
Framer.Device.deviceType = "apple-iphone-8-silver"

deviceHeight = Framer.Device.screen.height
deviceWidth = Framer.Device.screen.width

print "Device height: #{deviceHeight}"
print "Device width: #{deviceWidth}"

app = Framer.Importer.load("app.framer/imported/app@2x");

flow = new FlowComponent

# variables to hold a scale value we’ll use later
initialScale = 0.2

# array of our actions
actionButtons = []

# hide some layers for the initial state
app.App_actions.opacity = 0
app.App_overlay.opacity = 0
app.App_iconWrite.opacity = 0

# hide and set initial y position of the keyboard
app.App_keyboard.opacity = 0
app.App_keyboard.y += app.App_keyboard.height
app.App_iconWrite.rotation = -180

# Print all Layers in console
console.log("Layers:")
for layerName, value of app 
  console.log(layerName)

# Create an array of action layers (Add, Reminder, Task)
for i in [0...3]
  actionButtons.push app["App_action#{i+1}"]

# Add initial scale value to action buttons
for action in actionButtons
  action.scale = initialScale

# Adding states for each layer
app.App_overlay.states = 
  openActions:
    opacity: 1
  animationOptions:
    curve: "spring(400, 20, 0)"

app.App_actions.states = 
  openActions:
    opacity: 1
  animationOptions:
    curve: "spring(400, 20, 0)"

app.App_iconWrite.states = 
  openActions:
    opacity: 1
    rotation: 0
  animationOptions:
      curve: "spring(500,30,0)"

app.App_iconPlus.states =
  openActions: 
    opacity: 0
    rotation: 90
  animationOptions:
      curve: "spring(500,30,0)"

app.App_keyboard.states = 
  openInput:
    opacity: 1
    y: app.App_keyboard.y - app.App_keyboard.height
  animationOptions:
      curve: "spring(500,30,0)"

for action in actionButtons
  action.states = 
    openActions:
      scale: 1
    animationOptions:
      curve: "spring(500,30,0)"

# Function to switch state
switchStates = (state) ->
  for action in actionButtons
    action.animate(state)

  app.App_overlay.animate(state)
  app.App_actions.animate(state)
  app.App_iconWrite.animate(state)
  app.App_iconPlus.animate(state)

switchInput = (state) ->
  app.App_keyboard.animate(state)

app.App_floatingButton.on Events.Click, ->
  switchStates("openActions")

app.App_action2.on Events.Click, ->
  switchInput("openInput")

app.App_overlay.on Events.Click, ->
  switchStates("default")
  switchInput("default")

flow.showNext(app.App)

app.App_menu.bringToFront()
app.App_menu.on Events.Click, (event, layer) ->
  flow.showNext(app.DrawerOpen)

app.DrawerOpen_overlay.on Events.Click, ->
  flow.showPrevious()