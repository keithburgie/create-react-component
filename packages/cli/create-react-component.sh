#!/bin/bash

# Load configurations
CONFIG_FILE="create-react-component.config.sh"
if [[ -f $CONFIG_FILE ]]; then
    source $CONFIG_FILE
else
    echo -e "\033[31mError: Configuration file ($CONFIG_FILE) not found.\033[0m"
    exit 1
fi

# Check if component name is provided
if [[ -z "$COMPONENT_NAME" ]]; then
    echo -e "\033[31mError: Please provide a component name!\033[0m"
    exit 1
fi

# Create component directory
mkdir -p $COMPONENT_DIR
if [[ $? -ne 0 ]]; then
    echo -e "\033[31mError: Failed to create component directory at $COMPONENT_DIR.\033[0m"
    exit 1
fi

# Conditional file creation based on user choices
if $USE_TS; then
    touch $COMPONENT_DIR/$COMPONENT_NAME.tsx
    if [[ $? -ne 0 ]]; then
        echo -e "\033[31mError: Failed to create component file at $COMPONENT_DIR/$COMPONENT_NAME.tsx.\033[0m"
        exit 1
    fi
    if $INCLUDE_TYPES; then
        touch $COMPONENT_DIR/$COMPONENT_NAME.types.ts
        if [[ $? -ne 0 ]]; then
            echo -e "\033[31mError: Failed to create types file at $COMPONENT_DIR/$COMPONENT_NAME.types.ts.\033[0m"
            exit 1
        fi
    fi
else
    touch $COMPONENT_DIR/$COMPONENT_NAME.jsx
    if [[ $? -ne 0 ]]; then
        echo -e "\033[31mError: Failed to create component file at $COMPONENT_DIR/$COMPONENT_NAME.jsx.\033[0m"
        exit 1
    fi
fi

if $INCLUDE_STORIES; then
    touch $COMPONENT_DIR/$COMPONENT_NAME.stories.$EXT
    if [[ $? -ne 0 ]]; then
        echo -e "\033[31mError: Failed to create stories file at $COMPONENT_DIR/$COMPONENT_NAME.stories.$EXT.\033[0m"
        exit 1
    fi
fi

if $INCLUDE_TESTS; then
    touch $COMPONENT_DIR/$COMPONENT_NAME.test.$EXT
    if [[ $? -ne 0 ]]; then
        echo -e "\033[31mError: Failed to create test file at $COMPONENT_DIR/$COMPONENT_NAME.test.$EXT.\033[0m"
        exit 1
    fi
fi

# Generate component files based on templates
if $USE_TS; then
    if [[ $EXPORT_TYPE == "default" ]]; then
        cat <<EOT > $COMPONENT_DIR/$COMPONENT_NAME.tsx
import { HTMLAttributes, PropsWithChildren } from 'react';

interface BaseProps extends PropsWithChildren<HTMLAttributes<HTMLDivElement>> {}

export interface ${COMPONENT_NAME}Props extends BaseProps {}

const $COMPONENT_NAME = (props: ${COMPONENT_NAME}Props) => {
    return <div>$COMPONENT_NAME</div>;
};
export default $COMPONENT_NAME;
EOT
    else
        cat <<EOT > $COMPONENT_DIR/$COMPONENT_NAME.tsx
import { HTMLAttributes, PropsWithChildren } from 'react';

interface BaseProps extends PropsWithChildren<HTMLAttributes<HTMLDivElement>> {}

export interface ${COMPONENT_NAME}Props extends BaseProps {}

export const $COMPONENT_NAME = (props: ${COMPONENT_NAME}Props) => {
    return <div>$COMPONENT_NAME</div>;
};
EOT
    fi
else
    if [[ $EXPORT_TYPE == "default" ]]; then
        cat <<EOT > $COMPONENT_DIR/$COMPONENT_NAME.jsx
const $COMPONENT_NAME = (props) => {
    return <div>$COMPONENT_NAME</div>;
};
export default $COMPONENT_NAME;
EOT
    else
        cat <<EOT > $COMPONENT_DIR/$COMPONENT_NAME.jsx
export const $COMPONENT_NAME = (props) => {
    return <div>$COMPONENT_NAME</div>;
};
EOT
    fi
fi

# Populate index file based on export type
if [[ $EXPORT_TYPE == "default" ]]; then
    echo "export { default } from './$COMPONENT_NAME';" > $COMPONENT_DIR/index.tsx
else
    echo "export * from './$COMPONENT_NAME';" > $COMPONENT_DIR/index.tsx
fi


# Create style files
if [[ $STYLES == "CSS" || $STYLES == "SCSS" ]]; then
    STYLE_EXTENSION=".css"
    [[ $STYLES == "SCSS" ]] && STYLE_EXTENSION=".scss"

    if [[ $STYLES_PATH == "component-dir" ]]; then
        touch $COMPONENT_DIR/$COMPONENT_NAME_KEBAB$STYLE_EXTENSION
        if [[ $? -ne 0 ]]; then
            echo -e "\033[31mError: Failed to create style file at $COMPONENT_DIR/$COMPONENT_NAME_KEBAB$STYLE_EXTENSION.\033[0m"
            exit 1
        fi
    else
        touch $STYLES_PATH/$COMPONENT_NAME_KEBAB$STYLE_EXTENSION
        if [[ $? -ne 0 ]]; then
            echo -e "\033[31mError: Failed to create style file at $STYLES_PATH/$COMPONENT_NAME_KEBAB$STYLE_EXTENSION.\033[0m"
            exit 1
        fi
    fi
fi

# Feedback
echo -e "\033[32mComponent $COMPONENT_NAME created successfully!\033[0m"
