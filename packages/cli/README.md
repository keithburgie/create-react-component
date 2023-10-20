# Create React Component CLI

This CLI tool provides an easy way to create React components with a customizable setup. It supports various configurations such as TypeScript integration, inclusion of styles, Storybook files, and more.

## Installation

To install the Create React Component CLI tool globally:

```bash
npm install -g @kbui/create-react-component-cli
```

## Usage

After installation, you can use the CLI with the following command:

```bash
create-react-component ComponentName

# or...
crc ComponentName
```

Upon execution, the tool will prompt you for configuration choices if no configuration file is found. After setup, it will generate the requested files based on your preferences.

## Configuration

On the first run, the CLI will prompt you to set up configurations. These configurations will be saved in a `create-react-component.config.sh` file. You can modify this file at any time to adjust your preferences.

### Available Configurations:

- Base path for components.
- TypeScript or JavaScript preference.
- Option to include .types file.
- Option to include .stories file.
- Option to include .test file.
- Preference for default or named exports.
- CSS or SCSS style preference.
- CSS Modules usage.
- Location for style files (either within the component directory or a separate styles directory).

## Contributing

If you have suggestions or would like to contribute to the project, please open an issue or pull request on [the GitHub repository](https://github.com/keithburgie/create-react-component).

## License

[MIT](../../LICENSE)
