const inquirer = require("inquirer");
const fs = require("fs");
const os = require("os");
const path = require("path");

const BASE_PATH_DEFAULT = "./src/components";
const STYLES_PATH_DEFAULT = `${BASE_PATH_DEFAULT}/styles`;
const CONFIG_DIR = path.join(os.homedir(), ".create-react-component");

const getComponentConfig = async () => {
  const answers = await inquirer.prompt([
    {
      type: "input",
      name: "BASE_PATH",
      message: "Enter the base path for components",
      default: BASE_PATH_DEFAULT,
    },
    {
      type: "confirm",
      name: "USE_TYPESCRIPT",
      message: "Use TypeScript?",
      default: true,
    },
    {
      type: "confirm",
      name: "INCLUDE_TYPES_FILE",
      message: "Include .types file?",
      default: true,
      when: (answers) => answers.USE_TYPESCRIPT,
    },
    {
      type: "confirm",
      name: "INCLUDE_STORIES_FILE",
      message: "Include .stories file?",
      default: true,
    },
    {
      type: "confirm",
      name: "INCLUDE_TEST_FILE",
      message: "Include .test file?",
      default: true,
    },
    {
      type: "list",
      name: "EXPORTS_TYPE",
      message: "Use default or named exports?",
      choices: ["default", "named", "I don't know"],
      default: "default",
    },
    {
      type: "list",
      name: "USE_STYLES",
      message: "Create a CSS or SCSS file for the component?",
      choices: ["CSS", "SCSS", "No"],
      default: "SCSS",
    },
    {
      type: "confirm",
      name: "USE_CSS_MODULES",
      message: "Use CSS Modules?",
      default: false,
      when: (answers) => answers.USE_STYLES === "CSS",
    },
    {
      type: "list",
      name: "STYLES_LOCATION",
      message: "Where should these style files go?",
      choices: ["In the folder with my component", "In a styles directory"],
      default: "In a styles directory",
    },
    {
      type: "input",
      name: "STYLES_PATH",
      message: "Enter the styles path",
      default: STYLES_PATH_DEFAULT,
      when: (answers) => answers.STYLES_LOCATION === "In a styles directory",
    },
  ]);

  // Handle default path for styles if not in a styles directory
  if (answers.STYLES_LOCATION !== "In a styles directory") {
    answers.STYLES_PATH = answers.BASE_PATH;
  }

  // Save configurations
  if (!fs.existsSync(CONFIG_DIR)) {
    fs.mkdirSync(CONFIG_DIR, { recursive: true });
  }

  const configContent = `
BASE_PATH="${answers.BASE_PATH}"
USE_TYPESCRIPT="${answers.USE_TYPESCRIPT}"
INCLUDE_TYPES_FILE="${answers.INCLUDE_TYPES_FILE}"
INCLUDE_STORIES_FILE="${answers.INCLUDE_STORIES_FILE}"
INCLUDE_TEST_FILE="${answers.INCLUDE_TEST_FILE}"
EXPORTS_TYPE="${answers.EXPORTS_TYPE}"
USE_STYLES="${answers.USE_STYLES}"
USE_CSS_MODULES="${answers.USE_CSS_MODULES}"
STYLES_PATH="${answers.STYLES_PATH}"
  `;

  fs.writeFileSync(path.join(CONFIG_DIR, "config.js"), configContent);
  console.log(`Configurations saved to ${path.join(CONFIG_DIR, "config.js")}`);
  console.log(
    "You can modify this file at any time to adjust your configurations."
  );
};

module.exports = getComponentConfig;
