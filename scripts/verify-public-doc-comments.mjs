import { readFileSync, readdirSync } from "node:fs";
import { basename, resolve } from "node:path";

const sourceDirectory = resolve("src");
const minimumCoverage = 85;
const maximumMissingDeclarations = 58;
const declarationPattern =
  /^\s*pub(?:\(all\))?\s+(?:(?:async\s+)?fn(?:\[[^\]\n]*\])?|extern\s+"[^"]+"\s+fn|type|struct|enum|trait)\s+([^\s({=]+)/gm;
const docCommentPattern = /^\s*\/\/\/\s+\S/m;

const files = readdirSync(sourceDirectory, { withFileTypes: true })
  .filter(
    (entry) =>
      entry.isFile() &&
      entry.name.endsWith(".mbt") &&
      !entry.name.endsWith("_test.mbt") &&
      !entry.name.endsWith("_wbtest.mbt"),
  )
  .map((entry) => resolve(sourceDirectory, entry.name))
  .sort();

const declarations = [];
for (const file of files) {
  const source = readFileSync(file, "utf8");
  let blockStart = 0;
  for (const block of source.split("///|")) {
    const blockLine = source.slice(0, blockStart).split("\n").length;
    for (const match of block.matchAll(declarationPattern)) {
      const offset = match.index ?? 0;
      declarations.push({
        file: basename(file),
        line: blockLine + block.slice(0, offset).split("\n").length - 1,
        name: match[1],
        documented: docCommentPattern.test(block.slice(0, offset)),
      });
    }
    blockStart += block.length + "///|".length;
  }
}

const missing = declarations.filter((item) => !item.documented);
const documented = declarations.length - missing.length;
const coverage = (100 * documented) / declarations.length;
if (
  coverage < minimumCoverage ||
  missing.length > maximumMissingDeclarations
) {
  console.error(
    `public API docs regressed: coverage=${coverage.toFixed(1)}% missing=${missing.length}`,
  );
  for (const item of missing) {
    console.error(`- ${item.file}:${item.line} ${item.name}`);
  }
  process.exit(1);
}

console.log(
  JSON.stringify(
    {
      sourceFiles: files.length,
      publicDeclarations: declarations.length,
      documentedDeclarations: documented,
      missingDocComments: missing.length,
      coveragePercent: Number(coverage.toFixed(1)),
      enforcedFloorPercent: minimumCoverage,
      maximumMissingDeclarations,
      roadmapTargetPercent: 90,
    },
    null,
    2,
  ),
);
