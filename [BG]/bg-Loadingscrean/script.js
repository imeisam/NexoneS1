// Background Animation Setup
const background = document.getElementById("background");
const bgCtx = background.getContext("2d");
let width = window.innerWidth;
let height = window.innerHeight;

// Set canvas size with proper pixel ratio
const pixelRatio = window.devicePixelRatio || 1;
background.width = width * pixelRatio;
background.height = height * pixelRatio;
background.style.width = `${width}px`;
background.style.height = `${height}px`;
bgCtx.scale(pixelRatio, pixelRatio);

// Custom Cursor Setup
const cursor = document.createElement("div");
cursor.classList.add("cursor");
document.body.appendChild(cursor);

// Simple and reliable cursor update
document.addEventListener("mousemove", (e) => {
  cursor.style.left = e.clientX + "px";
  cursor.style.top = e.clientY + "px";
});

// Make sure cursor is visible
cursor.style.display = "block";
cursor.style.position = "fixed";
cursor.style.pointerEvents = "none";
cursor.style.zIndex = "9999";

// Add click effect with proper removal
document.addEventListener("mousedown", () => {
  cursor.classList.add("clicked");
});

document.addEventListener("mouseup", () => {
  cursor.classList.remove("clicked");
});

// Hide default cursor
document.body.style.cursor = "none";

// Show default cursor when leaving window
document.addEventListener("mouseleave", () => {
  cursor.style.display = "none";
  document.body.style.cursor = "auto";
});

document.addEventListener("mouseenter", () => {
  cursor.style.display = "block";
  document.body.style.cursor = "none";
});

// Make sure cursor works on all elements
document
  .querySelectorAll("button, a, input, [role='button']")
  .forEach((element) => {
    element.style.cursor = "none";
  });

// Particle system
class Particle {
  constructor() {
    this.reset();
    this.alpha = Math.random() * 0.4 + 0.3;
    this.pulseSpeed = Math.random() * 0.02 + 0.01;
    // Add more color variety
    this.colors = [
      "#ff1744", // bright red
      "#710b22", // dark red
      "#ff4081", // pink
      "#d50000", // deep red
    ];
    this.color = this.colors[Math.floor(Math.random() * this.colors.length)];
    this.glowSize = Math.random() * 4 + 3;
    this.rotationSpeed = (Math.random() - 0.5) * 0.02;
    this.rotation = Math.random() * Math.PI * 2;
  }

  reset() {
    this.x = Math.random() * width;
    this.y = Math.random() * height;
    this.size = Math.random() * 3 + 1.5;
    this.speedX = (Math.random() - 0.5) * 0.7;
    this.speedY = (Math.random() - 0.5) * 0.7;
    this.pulse = Math.random() * Math.PI * 2;
    this.trail = [];
    this.maxTrailLength = 5;
  }

  update() {
    // Store previous position for trail
    this.trail.unshift({ x: this.x, y: this.y });
    if (this.trail.length > this.maxTrailLength) {
      this.trail.pop();
    }

    this.x += this.speedX;
    this.y += this.speedY;
    this.pulse += this.pulseSpeed;
    this.rotation += this.rotationSpeed;

    // Enhanced pulsing effect
    this.currentSize = this.size * (1 + Math.sin(this.pulse) * 0.4);
    this.currentAlpha = this.alpha * (0.8 + Math.sin(this.pulse) * 0.5);

    // Add orbital movement
    const orbitRadius = 1;
    const orbitSpeed = this.pulse * 0.2;
    this.x += Math.cos(orbitSpeed) * orbitRadius;
    this.y += Math.sin(orbitSpeed) * orbitRadius;

    // Smooth boundary transition
    if (this.x < -50) this.x = width + 50;
    if (this.x > width + 50) this.x = -50;
    if (this.y < -50) this.y = height + 50;
    if (this.y > height + 50) this.y = -50;
  }

  draw() {
    // Draw trail
    this.trail.forEach((pos, index) => {
      const alpha = (1 - index / this.maxTrailLength) * 0.3;
      const trailGradient = bgCtx.createRadialGradient(
        pos.x,
        pos.y,
        0,
        pos.x,
        pos.y,
        this.currentSize * (this.glowSize * 0.5)
      );

      trailGradient.addColorStop(
        0,
        `${this.color}${Math.floor(alpha * 255)
          .toString(16)
          .padStart(2, "0")}`
      );
      trailGradient.addColorStop(1, "transparent");

      bgCtx.beginPath();
      bgCtx.arc(
        pos.x,
        pos.y,
        this.currentSize * (this.glowSize * 0.5),
        0,
        Math.PI * 2
      );
      bgCtx.fillStyle = trailGradient;
      bgCtx.fill();
    });

    // Main particle glow
    const gradient = bgCtx.createRadialGradient(
      this.x,
      this.y,
      0,
      this.x,
      this.y,
      this.currentSize * this.glowSize
    );

    gradient.addColorStop(0, `${this.color}`);
    gradient.addColorStop(0.4, `${this.color}88`);
    gradient.addColorStop(1, "transparent");

    bgCtx.beginPath();
    bgCtx.arc(this.x, this.y, this.currentSize * this.glowSize, 0, Math.PI * 2);
    bgCtx.fillStyle = gradient;
    bgCtx.fill();

    // Particle core with rotation
    bgCtx.save();
    bgCtx.translate(this.x, this.y);
    bgCtx.rotate(this.rotation);

    // Draw rotated shape
    bgCtx.beginPath();
    const sides = 6; // Hexagon shape
    for (let i = 0; i < sides; i++) {
      const angle = (i * 2 * Math.PI) / sides;
      const x = this.currentSize * Math.cos(angle);
      const y = this.currentSize * Math.sin(angle);
      if (i === 0) bgCtx.moveTo(x, y);
      else bgCtx.lineTo(x, y);
    }
    bgCtx.closePath();
    bgCtx.fillStyle = this.color;
    bgCtx.fill();

    bgCtx.restore();
  }
}

// Adjust particle system
const particles = [];
const particleCount = 30; // Slightly increased for better effect

// Initialize particles
for (let i = 0; i < particleCount; i++) {
  particles.push(new Particle());
}

// Gradient positions
let gradientAngle = 0;

// Optimize animation function
let lastTime = 0;
const targetFPS = 30; // Limit FPS for better performance
const frameInterval = 1000 / targetFPS;

function animateBackground(currentTime) {
  requestAnimationFrame(animateBackground);

  const deltaTime = currentTime - lastTime;
  if (deltaTime < frameInterval) return;

  lastTime = currentTime - (deltaTime % frameInterval);

  // Clear with enhanced fade effect
  bgCtx.fillStyle = "rgba(10, 10, 10, 0.15)";
  bgCtx.fillRect(0, 0, width, height);

  // Update and draw particles
  particles.forEach((particle) => {
    particle.update();
    particle.draw();
  });

  // Enhanced connecting lines with dynamic thickness
  for (let i = 0; i < particles.length; i++) {
    for (let j = i + 1; j < particles.length; j++) {
      const dx = particles[i].x - particles[j].x;
      const dy = particles[i].y - particles[j].y;
      const distance = Math.sqrt(dx * dx + dy * dy);

      if (distance < 180) {
        const opacity = (1 - distance / 180) * 0.2;
        const lineWidth = (1 - distance / 180) * 2;

        const gradient = bgCtx.createLinearGradient(
          particles[i].x,
          particles[i].y,
          particles[j].x,
          particles[j].y
        );

        gradient.addColorStop(
          0,
          `${particles[i].color}${Math.floor(opacity * 255)
            .toString(16)
            .padStart(2, "0")}`
        );
        gradient.addColorStop(
          0.5,
          `${particles[i].color}${Math.floor(opacity * 355)
            .toString(16)
            .padStart(2, "0")}`
        );
        gradient.addColorStop(
          1,
          `${particles[j].color}${Math.floor(opacity * 255)
            .toString(16)
            .padStart(2, "0")}`
        );

        bgCtx.beginPath();
        bgCtx.strokeStyle = gradient;
        bgCtx.lineWidth = lineWidth;
        bgCtx.moveTo(particles[i].x, particles[i].y);
        bgCtx.lineTo(particles[j].x, particles[j].y);
        bgCtx.stroke();
      }
    }
  }
}

// Optimize resize handler with debouncing
let resizeTimeout;
window.addEventListener("resize", () => {
  if (resizeTimeout) clearTimeout(resizeTimeout);

  resizeTimeout = setTimeout(() => {
    width = window.innerWidth;
    height = window.innerHeight;
    background.width = width * pixelRatio;
    background.height = height * pixelRatio;
    background.style.width = `${width}px`;
    background.style.height = `${height}px`;
    bgCtx.scale(pixelRatio, pixelRatio);
  }, 100);
});

// Start optimized background animation
requestAnimationFrame(animateBackground);

const songs = [
  {
    title: "Ayayayg",
    artist: "Bratia Stereo",
    path: "sound/song.mp3",
  },
  {
    title: "Happy",
    artist: "Pharrell Williams",
    path: "sound/82226_pharrell_williams_happy (1).mp3",
  },
];

let currentSongIndex = 0;
let isPlaying = false;
const audio = new Audio();

// Audio Context and Analyzer setup
let audioContext;
let analyser;
let source;
const canvas = document.getElementById("visualizer");
const ctx = canvas.getContext("2d");
let animationId;
let audioInitialized = false;

// Initialize Audio Context
async function initAudioContext() {
  if (!audioContext) {
    try {
      audioContext = new (window.AudioContext || window.webkitAudioContext)();

      // Resume context if it's suspended
      if (audioContext.state === "suspended") {
        await audioContext.resume();
      }

      analyser = audioContext.createAnalyser();
      analyser.fftSize = 256;
      source = audioContext.createMediaElementSource(audio);
      source.connect(analyser);
      analyser.connect(audioContext.destination);
      audioInitialized = true;
    } catch (error) {
      throw error;
    }
  }
}

// Visualizer function
function visualize() {
  if (!isPlaying) {
    if (animationId) {
      cancelAnimationFrame(animationId);
      animationId = null;
    }
    return;
  }

  const bufferLength = analyser.frequencyBinCount;
  const dataArray = new Uint8Array(bufferLength);
  analyser.getByteFrequencyData(dataArray);

  const WIDTH = canvas.width;
  const HEIGHT = canvas.height;
  const barWidth = (WIDTH / bufferLength) * 2.5;
  let barHeight;
  let x = 0;

  ctx.clearRect(0, 0, WIDTH, HEIGHT);

  // Add global glow effect
  ctx.shadowBlur = 15;
  ctx.shadowColor = "#710b22";

  for (let i = 0; i < bufferLength; i++) {
    // Enhance low frequencies (first third of the frequency range)
    let multiplier = 1;
    if (i < bufferLength / 3) {
      multiplier = 1.5; // Boost low frequencies by 50%
    }

    barHeight = dataArray[i] * 0.7 * multiplier;

    // Dynamic gradient based on frequency intensity
    const intensity = dataArray[i] / 255;
    const gradient = ctx.createLinearGradient(0, HEIGHT, 0, HEIGHT - barHeight);

    gradient.addColorStop(0, `rgba(113, 11, 34, ${0.8 + intensity * 0.2})`);
    gradient.addColorStop(0.5, `rgba(255, 23, 68, ${0.7 + intensity * 0.3})`);
    gradient.addColorStop(1, `rgba(255, 255, 255, ${intensity * 0.5})`);

    ctx.fillStyle = gradient;

    // Add individual bar glow effect
    ctx.shadowBlur = 10 + intensity * 10;

    // Draw bar with rounded corners
    const radius = barWidth / 4;
    roundedRect(ctx, x, HEIGHT - barHeight, barWidth - 1, barHeight, radius);

    x += barWidth + 1;
  }

  animationId = requestAnimationFrame(visualize);
}

// Helper function to draw rounded rectangles
function roundedRect(ctx, x, y, width, height, radius) {
  ctx.beginPath();
  ctx.moveTo(x + radius, y);
  ctx.lineTo(x + width - radius, y);
  ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
  ctx.lineTo(x + width, y + height);
  ctx.lineTo(x, y + height);
  ctx.lineTo(x, y + radius);
  ctx.quadraticCurveTo(x, y, x + radius, y);
  ctx.closePath();
  ctx.fill();
}

// Resize canvas function
function resizeCanvas() {
  const container = document.querySelector(".visualizer-container");
  canvas.width = container.offsetWidth;
  canvas.height = container.offsetHeight;
}

// Initialize canvas size
resizeCanvas();

// DOM Elements
const playBtn = document.getElementById("play");
const prevBtn = document.getElementById("prev");
const nextBtn = document.getElementById("next");
const volumeSlider = document.getElementById("volume");
const songTitle = document.querySelector(".song-title");
const artistName = document.querySelector(".artist");
const musicProgress = document.querySelector(".music-progress");
const progressContainer = document.querySelector(".progress-container");
const volumeIcon = document.querySelector(".volume-control i");
const volumeLevel = document.querySelector(".volume-level");

// Event Listeners
playBtn.addEventListener("click", togglePlay);
prevBtn.addEventListener("click", playPrevious);
nextBtn.addEventListener("click", playNext);
volumeSlider.addEventListener("input", updateVolume);
audio.addEventListener("timeupdate", updateProgress);
progressContainer.addEventListener("click", setProgress);
window.addEventListener("resize", resizeCanvas);
volumeIcon.addEventListener("click", () => {
  if (audio.volume > 0) {
    previousVolume = volumeSlider.value;
    volumeSlider.value = 0;
  } else {
    volumeSlider.value = previousVolume;
  }
  updateVolume();
});

// Functions
async function loadSong(song) {
  try {
    songTitle.textContent = song.title;
    artistName.textContent = "Loading...";

    // Check if file exists
    const fileExists = await checkFile(song.path);
    if (!fileExists) {
      throw new Error(`File not found: ${song.path}`);
    }

    // Stop current playback
    if (isPlaying) {
      await audio.pause();
      isPlaying = false;
    }

    // Reset audio source with error handling
    return new Promise((resolve, reject) => {
      const loadTimeout = setTimeout(() => {
        reject(new Error("Loading timeout"));
      }, 10000);

      audio.src = song.path;

      const handleSuccess = () => {
        clearTimeout(loadTimeout);
        artistName.textContent = song.artist;
        resolve();
      };

      const handleError = (error) => {
        clearTimeout(loadTimeout);
        reject(new Error("Error loading audio file"));
      };

      audio.addEventListener("canplaythrough", handleSuccess, { once: true });
      audio.addEventListener("error", handleError, { once: true });
    });
  } catch (error) {
    songTitle.textContent = "Error loading";
    artistName.textContent = error.message;
    throw error;
  }
}

async function togglePlay() {
  if (songs.length === 0) return;

  try {
    if (!audioInitialized) {
      await initAudioContext();
    }

    if (isPlaying) {
      await pauseSong();
    } else {
      await playSong();
    }
  } catch (error) {
    // Silent error handling
  }
}

async function playSong() {
  try {
    if (!audioInitialized) {
      await initAudioContext();
    }

    if (audioContext.state === "suspended") {
      await audioContext.resume();
    }

    playBtn.innerHTML = '<i class="fas fa-pause"></i>';

    // Make sure the audio is loaded
    if (audio.readyState < 3) {
      await new Promise((resolve) => {
        audio.addEventListener("canplay", resolve, { once: true });
      });
    }

    await audio.play();
    isPlaying = true;
    visualize();
  } catch (error) {
    artistName.textContent = "Error: " + error.message;
    isPlaying = false;
    playBtn.innerHTML = '<i class="fas fa-play"></i>';
  }
}

async function pauseSong() {
  try {
    await audio.pause();
    isPlaying = false;
    playBtn.innerHTML = '<i class="fas fa-play"></i>';
  } catch (error) {
    // Silent error handling
  }
}

function playPrevious() {
  if (songs.length === 0) return;

  currentSongIndex--;
  if (currentSongIndex < 0) {
    currentSongIndex = songs.length - 1;
  }
  loadSong(songs[currentSongIndex]);
  if (isPlaying) playSong();
}

function playNext() {
  if (songs.length === 0) return;

  currentSongIndex++;
  if (currentSongIndex >= songs.length) {
    currentSongIndex = 0;
  }
  loadSong(songs[currentSongIndex]);
  if (isPlaying) playSong();
}

function updateVolume() {
  const value = volumeSlider.value;
  audio.volume = value / 100;
  volumeLevel.textContent = `${value}%`;

  // Update volume icon based on level
  if (value == 0) {
    volumeIcon.className = "fas fa-volume-mute";
  } else if (value < 30) {
    volumeIcon.className = "fas fa-volume-off";
  } else if (value < 70) {
    volumeIcon.className = "fas fa-volume-down";
  } else {
    volumeIcon.className = "fas fa-volume-up";
  }
}

function updateProgress(e) {
  if (isPlaying) {
    const { duration, currentTime } = e.srcElement;
    const progressPercent = (currentTime / duration) * 100;
    musicProgress.style.width = `${progressPercent}%`;
  }
}

function setProgress(e) {
  const width = this.clientWidth;
  const clickX = e.offsetX;
  const duration = audio.duration;
  audio.currentTime = (clickX / width) * duration;
}

// Loading screen functionality
let loadingProgress = 0;
const progressBar = document.querySelector(".progress");
const container = document.querySelector(".container");
const loadingBar = document.querySelector(".loading-bar");

// Handle FiveM loading events
window.addEventListener("message", function (e) {
  if (e.data.eventName === "loadProgress") {
    loadingProgress = e.data.loadFraction * 100;
    progressBar.style.width = `${loadingProgress}%`;

    if (loadingProgress >= 100) {
      setTimeout(() => {
        loadingBar.style.opacity = "0";
        loadingBar.style.transition = "opacity 0.5s ease";
        setTimeout(() => {
          loadingBar.style.display = "none";
        }, 500);
      }, 1000);
    }
  }
});

// For development/testing only - remove in production
if (!window.invokeNative) {
  function simulateLoading() {
    loadingProgress += Math.random() * 25;
    if (loadingProgress > 100) {
      loadingProgress = 100;
      setTimeout(() => {
        loadingBar.style.opacity = "0";
        loadingBar.style.transition = "opacity 0.5s ease";
        setTimeout(() => {
          loadingBar.style.display = "none";
        }, 500);
      }, 500);
      return;
    }

    progressBar.style.width = `${loadingProgress}%`;

    if (loadingProgress < 100) {
      setTimeout(simulateLoading, 500);
    }
  }

  // Start loading animation when page loads (development only)
  document.addEventListener("DOMContentLoaded", () => {
    loadingBar.style.opacity = "1";
    loadingBar.style.transition = "opacity 0.5s ease";
    simulateLoading();
  });
}

// Update server info
function updateServerInfo() {
  const timeElement = document.getElementById("time");
  const now = new Date();
  const hours = now.getHours().toString().padStart(2, "0");
  const minutes = now.getMinutes().toString().padStart(2, "0");
  const seconds = now.getSeconds().toString().padStart(2, "0");
  timeElement.textContent = `${hours}:${minutes}:${seconds}`;
}

// Function to check if file exists
async function checkFile(url) {
  try {
    const response = await fetch(url);
    return response.ok;
  } catch (error) {
    return false;
  }
}

// Enhanced song loading function
async function loadSongsFromFolder() {
  const soundFolder = "sound/";
  const supportedFormats = [".mp3", ".wav", ".ogg"];

  // Check if the first song exists
  const firstSong = songs[0];
  if (firstSong) {
    const exists = await checkFile(firstSong.path);
    if (!exists) {
      songTitle.textContent = "Sound files not found";
      artistName.textContent = "Please check sound folder path";
      return;
    }
  }

  // Add error handling for audio loading
  audio.addEventListener("error", (e) => {
    artistName.textContent = "Error loading audio file";
  });

  // Auto-advance to next song when current one ends
  audio.addEventListener("ended", () => {
    playNext();
  });

  // Update display when loading new song
  audio.addEventListener("loadstart", () => {
    artistName.textContent = "Loading...";
  });

  // Update display when song is loaded
  audio.addEventListener("loadeddata", () => {
    if (songs[currentSongIndex]) {
      artistName.textContent = songs[currentSongIndex].artist;
    }
  });

  // Initialize audio context when user interacts
  document.addEventListener(
    "click",
    () => {
      if (!audioContext) {
        initAudioContext();
      }
    },
    { once: true }
  );
}

// Initialize
window.addEventListener("load", async () => {
  try {
    // Set up volume first
    audio.volume = 0.5;
    volumeSlider.value = 50;
    updateVolume();

    // Try to load the first song
    if (songs.length > 0) {
      await loadSong(songs[0]);

      // Try autoplay or wait for user interaction
      try {
        await playSong();
      } catch (error) {
        document.addEventListener(
          "click",
          async () => {
            if (!isPlaying) {
              try {
                await playSong();
              } catch (e) {
                // Silent error handling
              }
            }
          },
          { once: true }
        );
      }
    }
  } catch (error) {
    // Silent error handling
  }
});

// Function to format song name from filename
function formatSongName(filename) {
  // Remove extension and replace underscores/hyphens with spaces
  return filename
    .replace(/\.[^/.]+$/, "")
    .replace(/[_-]/g, " ")
    .replace(/\b\w/g, (l) => l.toUpperCase());
}

// Update time display with larger format
function updateServerInfo() {
  const timeElement = document.getElementById("time");
  const now = new Date();
  const hours = now.getHours().toString().padStart(2, "0");
  const minutes = now.getMinutes().toString().padStart(2, "0");
  const seconds = now.getSeconds().toString().padStart(2, "0");
  timeElement.textContent = `${hours}:${minutes}:${seconds}`;
}

// Update time more frequently
setInterval(updateServerInfo, 1000);
