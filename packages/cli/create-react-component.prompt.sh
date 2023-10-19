# create-react-component.prompt.sh

# Default configurations
BASE_PATH_DEFAULT="./src/components"
STYLES_PATH_DEFAULT="${BASE_PATH_DEFAULT}/styles"
USE_TYPESCRIPT_DEFAULT="yes"
INCLUDE_TYPES_FILE_DEFAULT="yes"
INCLUDE_STORIES_FILE_DEFAULT="yes"
INCLUDE_TEST_FILE_DEFAULT="yes"
EXPORTS_TYPE_DEFAULT="default"
USE_STYLES_DEFAULT="SCSS"
USE_CSS_MODULES_DEFAULT="no"
STYLES_LOCATION_DEFAULT="In a styles directory"

echo "Setting up Create React Component configurations."

# Prompt user for BASE_PATH
read -p "Enter the base path for components [$BASE_PATH_DEFAULT]: " BASE_PATH
BASE_PATH="${BASE_PATH:-$BASE_PATH_DEFAULT}"

# 1. TypeScript or JavaScript
read -p "Use TypeScript? [yes/no] [$USE_TYPESCRIPT_DEFAULT]: " USE_TYPESCRIPT
USE_TYPESCRIPT="${USE_TYPESCRIPT:-$USE_TYPESCRIPT_DEFAULT}"

if [ "$USE_TYPESCRIPT" = "yes" ]; then
    # 1.1. Include .types file?
    read -p "Include .types file? [yes/no] [$INCLUDE_TYPES_FILE_DEFAULT]: " INCLUDE_TYPES_FILE
    INCLUDE_TYPES_FILE="${INCLUDE_TYPES_FILE:-$INCLUDE_TYPES_FILE_DEFAULT}"
else
    INCLUDE_TYPES_FILE="no"
fi

# 2. Include .stories file?
read -p "Include .stories file? [yes/no] [$INCLUDE_STORIES_FILE_DEFAULT]: " INCLUDE_STORIES_FILE
INCLUDE_STORIES_FILE="${INCLUDE_STORIES_FILE:-$INCLUDE_STORIES_FILE_DEFAULT}"

# 3. Include .test file?
read -p "Include .test file? [yes/no] [$INCLUDE_TEST_FILE_DEFAULT]: " INCLUDE_TEST_FILE
INCLUDE_TEST_FILE="${INCLUDE_TEST_FILE:-$INCLUDE_TEST_FILE_DEFAULT}"

# 4. Use default or named exports?
read -p "Use default or named exports? [default/named/I don't know] [$EXPORTS_TYPE_DEFAULT]: " EXPORTS_TYPE
EXPORTS_TYPE="${EXPORTS_TYPE:-$EXPORTS_TYPE_DEFAULT}"

# 5. Create a CSS or SCSS file for the component?
read -p "Create a CSS or SCSS file for the component? [CSS/SCSS/No] [$USE_STYLES_DEFAULT]: " USE_STYLES
USE_STYLES="${USE_STYLES:-$USE_STYLES_DEFAULT}"

if [ "$USE_STYLES" = "CSS" ]; then
    # 5.1. Use CSS Modules?
    read -p "Use CSS Modules? [yes/no] [$USE_CSS_MODULES_DEFAULT]: " USE_CSS_MODULES
    USE_CSS_MODULES="${USE_CSS_MODULES:-$USE_CSS_MODULES_DEFAULT}"
fi

# 5.2. Where should these style files go?
read -p "Where should these style files go? [In the folder with my component/In a styles directory] [$STYLES_LOCATION_DEFAULT]: " STYLES_LOCATION
STYLES_LOCATION="${STYLES_LOCATION:-$STYLES_LOCATION_DEFAULT}"

if [ "$STYLES_LOCATION" = "In a styles directory" ]; then
    # Prompt user for STYLES_PATH
    read -p "Enter the styles path [$STYLES_PATH_DEFAULT]: " STYLES_PATH
    STYLES_PATH="${STYLES_PATH:-$STYLES_PATH_DEFAULT}"
else
    STYLES_PATH="$BASE_PATH"
fi

# Save configurations to a file
cat << EOF > create-react-component.config.sh
BASE_PATH="$BASE_PATH"
USE_TYPESCRIPT="$USE_TYPESCRIPT"
INCLUDE_TYPES_FILE="$INCLUDE_TYPES_FILE"
INCLUDE_STORIES_FILE="$INCLUDE_STORIES_FILE"
INCLUDE_TEST_FILE="$INCLUDE_TEST_FILE"
EXPORTS_TYPE="$EXPORTS_TYPE"
USE_STYLES="$USE_STYLES"
USE_CSS_MODULES="$USE_CSS_MODULES"
STYLES_PATH="$STYLES_PATH"
EOF

echo "Configurations saved to create-react-component.config.sh"
echo "You can modify create-react-component.config.sh at any time to adjust your configurations."
