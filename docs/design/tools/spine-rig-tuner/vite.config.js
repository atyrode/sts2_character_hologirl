import { createReadStream, existsSync } from "node:fs";
import { dirname, extname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

const configDir = dirname(fileURLToPath(import.meta.url));

function artArchiveMiddleware() {
  const archiveRoot = resolve(configDir, "../../art_archive");
  const contentTypes = new Map([
    [".png", "image/png"],
    [".jpg", "image/jpeg"],
    [".jpeg", "image/jpeg"],
    [".json", "application/json"]
  ]);

  return {
    name: "spine-rig-tuner-art-archive",
    configureServer(server) {
      server.middlewares.use("/art_archive", (request, response, next) => {
        const requestPath = decodeURIComponent((request.url || "").split("?")[0]).replace(/^\/+/, "");
        const filePath = resolve(archiveRoot, requestPath);
        if (!filePath.startsWith(archiveRoot) || !existsSync(filePath)) {
          next();
          return;
        }
        response.setHeader("Content-Type", contentTypes.get(extname(filePath).toLowerCase()) || "application/octet-stream");
        createReadStream(filePath).pipe(response);
      });
    }
  };
}

export default defineConfig({
  plugins: [react(), artArchiveMiddleware()],
  server: {
    fs: {
      allow: [
        resolve(configDir),
        resolve(configDir, "../..")
      ]
    }
  },
  build: {
    outDir: "dist",
    emptyOutDir: true
  }
});
