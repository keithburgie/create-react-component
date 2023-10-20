#!/usr/bin/env node

const path = require("path");
const os = require("os");
const { generateComponent } = require("shared").generateComponent;
const getComponentConfig = require("shared").getComponentConfig;

// Configuration path details
const CONFIG_DIR = path.join(os.homedir(), ".create-react-component");
const CONFIG_FILE = path.join(CONFIG_DIR, "config.js");

const runCli = async () => {
  // Fetch component configuration
  const componentConfig = await getComponentConfig();

  // We're assuming the config from `getComponentConfig` is already stored and we don't need to fetch it again
  // directly pass it to the `generateComponent` function
  generateComponent(componentConfig);

  console.log("Component creation complete!");
};

runCli();
