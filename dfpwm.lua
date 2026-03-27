local speaker = peripheral.find("speaker")

local file = fs.open("ss.dfpwm", "rb")

while true do
  local chunk = file:read(16 * 1024)
  if not chunk then break end
  
  while not speaker.playAudio(chunk) do
    os.pullEvent("speaker_audio_empty")
  end
end

file.close()
