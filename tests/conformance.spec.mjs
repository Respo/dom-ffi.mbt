import { expect, test } from "@playwright/test";

test("MoonBit bindings preserve core DOM runtime contracts", async ({ page }) => {
  const pageErrors = [];
  const consoleProblems = [];
  await page.addInitScript(() => {
    globalThis.__domFfiRejections = [];
    addEventListener("unhandledrejection", event => globalThis.__domFfiRejections.push(String(event.reason)));
  });
  page.on("pageerror", (error) => pageErrors.push(error.message));
  page.on("console", (message) => {
    if (["warning", "error"].includes(message.type())) {
      consoleProblems.push(`${message.type()}: ${message.text()}`);
    }
  });

  await page.goto("/");
  await expect
    .poll(() =>
      page.evaluate(() => globalThis.__domFfiConformance?.passed ?? 0),
    )
    .toBe(167);

  const evidence = await page.evaluate(() => globalThis.__domFfiConformance);
  expect(evidence.passed).toBe(evidence.assertions.length);
  expect(new Set(evidence.assertions).size).toBe(evidence.assertions.length);
  expect(pageErrors).toEqual([]);
  expect(consoleProblems).toEqual([]);
  expect(await page.evaluate(() => globalThis.__domFfiRejections)).toEqual([]);
});
