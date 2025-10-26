#!/bin/bash

source ./core/functions.sh

config_setup() {
    spinner "Copying Hyprnosis theme files..." cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"
    spinner "Copying config files..." cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"
    spinner "Cloning wallpapers repo..." git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
    spinner "Copying wallpapers..." cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/"
    rm -rf /tmp/wallpapers
    chmod +x "$HOME/.config/hyprnosis/modules/"*
    log_success "Configuration setup complete"
}

setup_hyprnosis_alias() {
    SHELL_RC="$HOME/.bashrc"
    FUNCTION_NAME="hyprnosis"
    SCRIPT_PATH="$HOME/.config/hyprnosis/modules/hyprnosis_tui.sh"
    FUNCTION_DEF=$(cat <<EOF
# hyprnosis CLI
$FUNCTION_NAME() {
    bash "$SCRIPT_PATH"
}
EOF
)
    if ! grep -q "$FUNCTION_NAME()" "$SHELL_RC"; then
        echo "$FUNCTION_DEF" >> "$SHELL_RC"
        log_success "Alias function '$FUNCTION_NAME' added to $SHELL_RC"
    else
        log_info "Function '$FUNCTION_NAME' already exists in $SHELL_RC"
    fi
}
