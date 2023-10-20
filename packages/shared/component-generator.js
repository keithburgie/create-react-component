const fs = require("fs");
const path = require("path");
const os = require("os");

function createFile(filePath, content = "") {
  try {
    fs.writeFileSync(filePath, content, "utf-8");
  } catch (err) {
    console.error(
      "\x1b[31m",
      `Error: Failed to create file at ${filePath}.`,
      "\x1b[0m"
    );
    process.exit(1);
  }
}

function generateComponent(componentDetails) {
  const {
    COMPONENT_NAME,
    COMPONENT_DIR,
    USE_TS,
    INCLUDE_TYPES,
    INCLUDE_STORIES,
    INCLUDE_TESTS,
    EXPORT_TYPE,
    STYLES,
    STYLES_PATH,
    EXT,
    COMPONENT_NAME_KEBAB,
  } = componentDetails;

  // Create component directory
  try {
    fs.mkdirSync(COMPONENT_DIR, { recursive: true });
  } catch (err) {
    console.error(
      "\x1b[31m",
      `Error: Failed to create component directory at ${COMPONENT_DIR}.`,
      "\x1b[0m"
    );
    process.exit(1);
  }

  // Conditional file creation based on user choices
  const fileExt = USE_TS ? "tsx" : "jsx";
  createFile(path.join(COMPONENT_DIR, `${COMPONENT_NAME}.${fileExt}`));

  if (USE_TS && INCLUDE_TYPES) {
    createFile(path.join(COMPONENT_DIR, `${COMPONENT_NAME}.types.ts`));
  }

  if (INCLUDE_STORIES) {
    createFile(path.join(COMPONENT_DIR, `${COMPONENT_NAME}.stories.${EXT}`));
  }

  if (INCLUDE_TESTS) {
    createFile(path.join(COMPONENT_DIR, `${COMPONENT_NAME}.test.${EXT}`));
  }

  // Generate component files based on templates
  const componentTemplate = USE_TS
    ? EXPORT_TYPE === "default"
      ? `import { HTMLAttributes, PropsWithChildren } from 'react';
    
interface BaseProps extends PropsWithChildren<HTMLAttributes<HTMLDivElement>> {}
export interface ${COMPONENT_NAME}Props extends BaseProps {}
const ${COMPONENT_NAME} = (props: ${COMPONENT_NAME}Props) => {
    return <div>${COMPONENT_NAME}</div>;
};
export default ${COMPONENT_NAME};
`
      : `import { HTMLAttributes, PropsWithChildren } from 'react';
    
interface BaseProps extends PropsWithChildren<HTMLAttributes<HTMLDivElement>> {}
export interface ${COMPONENT_NAME}Props extends BaseProps {}
export const ${COMPONENT_NAME} = (props: ${COMPONENT_NAME}Props) => {
    return <div>${COMPONENT_NAME}</div>;
};
`
    : EXPORT_TYPE === "default"
    ? `const ${COMPONENT_NAME} = (props) => {
    return <div>${COMPONENT_NAME}</div>;
};
export default ${COMPONENT_NAME};
`
    : `export const ${COMPONENT_NAME} = (props) => {
    return <div>${COMPONENT_NAME}</div>;
};
`;

  createFile(
    path.join(COMPONENT_DIR, `${COMPONENT_NAME}.${fileExt}`),
    componentTemplate
  );

  // Populate index file based on export type
  const indexContent =
    EXPORT_TYPE === "default"
      ? `export { default } from './${COMPONENT_NAME}';`
      : `export * from './${COMPONENT_NAME}';`;

  createFile(path.join(COMPONENT_DIR, `index.${fileExt}`), indexContent);

  // Create style files
  if (STYLES === "CSS" || STYLES === "SCSS") {
    const STYLE_EXTENSION = STYLES === "SCSS" ? ".scss" : ".css";
    const stylePath =
      STYLES_PATH === "component-dir"
        ? path.join(COMPONENT_DIR, `${COMPONENT_NAME_KEBAB}${STYLE_EXTENSION}`)
        : path.join(STYLES_PATH, `${COMPONENT_NAME_KEBAB}${STYLE_EXTENSION}`);

    createFile(stylePath);
  }

  // Feedback
  console.log(
    "\x1b[32m",
    `Component ${COMPONENT_NAME} created successfully!`,
    "\x1b[0m"
  );
}

module.exports = {
  generateComponent,
};
