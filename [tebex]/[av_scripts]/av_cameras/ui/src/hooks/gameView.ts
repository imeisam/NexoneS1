import { useEffect, useRef, useState } from "react";
import { fetchNui } from "./useNuiEvents";

class GameView {
  canvas: HTMLCanvasElement | null = null;
  vertexShaderSrc: string;
  fragmentShaderSrc: string;
  interval: number | null = null;

  constructor() {
    this.vertexShaderSrc = `
      attribute vec2 a_position;
      attribute vec2 a_texcoord;
      uniform mat3 u_matrix;
      varying vec2 textureCoordinate;
      void main() {
          gl_Position = vec4(a_position, 0.0, 1.0);
          textureCoordinate = a_texcoord;
      }
    `;

    this.fragmentShaderSrc = `
      varying highp vec2 textureCoordinate;
      uniform sampler2D external_texture;
      void main() {
      gl_FragColor = texture2D(external_texture, textureCoordinate);
      }
    `;
  }

  makeShader = (gl: WebGLRenderingContext, type: number, src: string) => {
    const shader: any = gl.createShader(type);

    gl.shaderSource(shader, src);
    gl.compileShader(shader);

    const infoLog = gl.getShaderInfoLog(shader);
    if (infoLog) {
      console.error(infoLog);
    }

    return shader;
  };

  createTexture(gl: WebGLRenderingContext) {
    const tex = gl.createTexture();

    const texPixels = new Uint8Array([0, 0, 255, 255]);

    gl.bindTexture(gl.TEXTURE_2D, tex);
    gl.texImage2D(
      gl.TEXTURE_2D,
      0,
      gl.RGBA,
      1,
      1,
      0,
      gl.RGBA,
      gl.UNSIGNED_BYTE,
      texPixels
    );

    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);

    // Magic hook sequence
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.MIRRORED_REPEAT);
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);

    // Reset
    gl.texParameterf(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);

    return tex;
  }

  createBuffers = (gl: WebGLRenderingContext) => {
    const vertexBuff = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuff);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]),
      gl.STATIC_DRAW
    );

    const texBuff = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, texBuff);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      new Float32Array([0, 0, 1, 0, 0, 1, 1, 1]),
      gl.STATIC_DRAW
    );

    return { vertexBuff, texBuff };
  };

  createProgram = (gl: WebGLRenderingContext) => {
    const vertexShader = this.makeShader(
      gl,
      gl.VERTEX_SHADER,
      this.vertexShaderSrc
    );
    const fragmentShader = this.makeShader(
      gl,
      gl.FRAGMENT_SHADER,
      this.fragmentShaderSrc
    );

    const program = gl.createProgram()!;
    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program);
    gl.useProgram(program);

    const vloc = gl.getAttribLocation(program, "a_position");
    const tloc = gl.getAttribLocation(program, "a_texcoord");

    return { program, vloc, tloc };
  };

  createStuff(gl: WebGLRenderingContext) {
    const tex = this.createTexture(gl);
    const { program, vloc, tloc } = this.createProgram(gl);
    const { vertexBuff, texBuff } = this.createBuffers(gl);

    gl.useProgram(program);
    gl.bindTexture(gl.TEXTURE_2D, tex);
    gl.uniform1i(gl.getUniformLocation(program, "external_texture"), 0);

    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuff);
    gl.vertexAttribPointer(vloc, 2, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(vloc);

    gl.bindBuffer(gl.ARRAY_BUFFER, texBuff);
    gl.vertexAttribPointer(tloc, 2, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(tloc);

    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
  }

  render(gl: WebGLRenderingContext) {
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
    gl.finish();
  }

  createGameView = (canvas: HTMLCanvasElement) => {
    this.canvas = canvas;

    // Set the desired resolution
    const width = 1280;
    const height = 720;

    const gl = this.canvas.getContext("webgl", {
      antialias: false,
      depth: false,
      stencil: false,
      alpha: false,
      desynchronized: true,
      failIfMajorPerformanceCaveat: false,
    });

    if (!gl) {
      console.error(
        "Unable to initialize WebGL. Your browser may not support it."
      );
      return;
    }

    const gameView = {
      canvas,
      gl,
      animationFrame: undefined,
      resize: (width: number, height: number) => {
        gl.viewport(0, 0, width, height);
        gl.canvas.width = width;
        gl.canvas.height = height;
      },
    };
    gameView.resize(width, height);

    this.createStuff(gl);

    this.interval = setInterval(() => {
      this.render(gl);
    }, 1000 / 60);

    return gameView;
  };

  stop() {
    if (this.canvas) {
      this.canvas.style.display = "none";
    }
    if (this.interval) {
      clearInterval(this.interval);
    }
  }
}

const uploadVideo = async (
  file: Blob,
  hook: string,
  service: string,
  identifier: string
) => {
  const formData = new FormData();
  try {
    let response, responseData;
    if (service === "fivemanage") {
      formData.append("video", file);
      response = await fetch("https://api.fivemanage.com/api/video", {
        method: "POST",
        headers: { Authorization: hook },
        body: formData,
      });
      if (!response.ok) {
        if (response.status === 401) {
          throw new Error(
            `Failed to upload video to FiveManage: SET TOKEN PROPERLY IN server/editable/token.lua | ${response.status}`
          );
        } else {
          throw new Error(
            `Failed to upload video to FiveManage: ${response.status}`
          );
        }
      }
      responseData = await response.json();
      fetchNui("av_cameras", "saveVideo", {
        url: responseData.url,
        identifier,
      });
    } else if (service === "fivemerr") {
      formData.append("file", file, "video.webm");
      response = await fetch("https://api.fivemerr.com/v1/media/videos", {
        method: "POST",
        headers: { Authorization: hook },
        body: formData,
      });
      if (!response.ok) {
        if (response.status === 401) {
          throw new Error(
            `Failed to upload video to Fivemerr: SET TOKEN PROPERLY IN server/editable/token.lua | ${response.status}`
          );
        } else {
          throw new Error(
            `Failed to upload video to Fivemerr: ${response.status}`
          );
        }
      }
      responseData = await response.json();
      fetchNui("av_cameras", "saveVideo", {
        url: responseData.url,
        identifier,
      });
    }
  } catch (error: any) {
    console.error("^1[ERROR]:^3", error.message);
  }
};

export const useGameViewWithRecording = (
  canvasRef: React.RefObject<HTMLCanvasElement>,
  setRecording: (state: boolean) => void
) => {
  let recordingTimeout: ReturnType<typeof setTimeout>;
  const gameViewRef = useRef<GameView | null>(null);
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  useEffect(() => {
    if (canvasRef.current) {
      gameViewRef.current = new GameView();
      gameViewRef.current.createGameView(canvasRef.current);
    }

    return () => {
      if (gameViewRef.current) {
        gameViewRef.current.stop();
      }
    };
  }, [canvasRef]);

  const startRecording = (
    identifier: string,
    hook: string,
    service: string
  ) => {
    if (canvasRef.current) {
      const canvasElement = canvasRef.current;
      canvasElement.width = 1280;
      canvasElement.height = 720;
      const videoStream = canvasElement.captureStream(30);
      const videoChunks: Blob[] = [];
      mediaRecorderRef.current = new MediaRecorder(videoStream, {
        mimeType: "video/webm;codecs=vp9",
      });
      mediaRecorderRef.current.start();
      mediaRecorderRef.current.ondataavailable = (e) =>
        e.data.size > 0 && videoChunks.push(e.data);
      mediaRecorderRef.current.onstop = async () => {
        const file = new Blob(videoChunks, { type: "video/webm" });
        if (file.size > 0) {
          await uploadVideo(file, hook, service, identifier);
        }
      };
      recordingTimeout = setTimeout(() => {
        stopRecording();
      }, 60000);
    }
  };

  const stopRecording = () => {
    if (
      mediaRecorderRef.current &&
      mediaRecorderRef.current.state === "recording"
    ) {
      mediaRecorderRef.current.stop();
      clearTimeout(recordingTimeout);
      setRecording(false);
    }
  };

  return { startRecording, stopRecording };
};
