import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./tests",
  fullyParallel: true,
  use: {
    baseURL: "http://127.0.0.1:4174",
    browserName: "chromium",
    headless: true,
  },
  webServer: {
    command: "python3 -m http.server 4174 --bind 127.0.0.1",
    port: 4174,
    reuseExistingServer: !process.env.CI,
  },
});
