# NexOne Loading Screen

A modern loading screen with music player for FiveM servers.

## Sound Setup Instructions

1. Create a folder named `sound` in the same directory as your loading screen files.
2. Add your music files to the `sound` folder.
3. Supported audio formats:
   - MP3 (.mp3)
   - WAV (.wav)
   - OGG (.ogg)

### File Naming Convention

- Use descriptive names for your music files
- Use hyphens (-) or underscores (\_) to separate words
- Examples:
  - `track1.mp3`
  - `background-music.mp3`
  - `loading_theme.mp3`

### Directory Structure

```
your-resource/
├── index.html
├── styles.css
├── script.js
├── sound/
│   ├── track1.mp3
│   ├── track2.mp3
│   └── track3.mp3
└── README.md
```

## Features

- Automatic song loading from sound folder
- Modern visualizer with low frequency enhancement
- Volume control with visual feedback
- Auto-advance to next track
- Error handling for missing or corrupt files
- Supports multiple audio formats

## Usage

1. Place your audio files in the `sound` folder
2. The player will automatically detect and load the songs
3. Use the controls to:
   - Play/Pause
   - Skip tracks
   - Adjust volume
   - View song progress

## Troubleshooting

- If songs don't play, check that:
  - Files are in the correct format (mp3, wav, or ogg)
  - Files are properly named
  - Files are placed in the `sound` folder
  - Audio files are not corrupted

For any issues, check the browser console for error messages.
