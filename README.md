# Deviknob — Wi-Fi Volume Knob for Devialet Phantom
Devia-knob is a home-made volume controller for Devialet speakers. It connects to your Devialet system over Wi-Fi using the official Devialet IP Control API, allowing smooth, hardware-based volume control.

---

## ✨ Features

- 🎚️ Rotary knob to adjust volume in real-time  
- 📡 Wi-Fi connection to Devialet (Phantom / Arch / Dialog / Dione)  
- 🖥️ Touchscreen circular UI (LVGL-based)  
- 🔇 Mute / Unmute button  
- 🔄 Auto-sync with current system volume  
- 🧩 Built-in Devialet API client (no external app required)

---

## 🧠 How it works

<img width="1024" height="1024" alt="ChatGPT Image 23 oct  2025 à 13_28_58" src="https://github.com/user-attachments/assets/41d102dc-6025-48ee-9c6c-183fe6336beb" />

1. The CrowPanel connects to your local Wi-Fi network.
2. It discovers or uses a fixed IP of your Devialet device.
3. The firmware queries `/ipcontrol/v1/devices/current` to retrieve the `systemId`.
4. Volume changes are sent to: `POST /ipcontrol/v1/systems/{systemId}/sources/current/soundControl/volume`
5. LVGL draws a circular gauge reflecting the current volume, and the rotary encoder updates it smoothly.

## 🔧 How devialet_volume.sh works:
It sends HTTP POST requests to the speaker’s IP address and system ID using curl.
Depending on the argument you give:
- up → increases the volume
- down → decreases the volume
- a number (e.g., 45) → sets the volume to that percentage
- get → retrieves and displays the current volume using jq for JSON formatting

## 🖥️ Automation script 

// IN PROCESS //

