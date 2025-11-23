config_setup() {
  log_info "Copying Hyprnosis theme files..."
  cp -r "$HOME/.config/hyprnosis/themes/Hyprnosis/." "$HOME/.config/"

  log_info "Copying config files..."
  cp -r "$HOME/.config/hyprnosis/config/"* "$HOME/.config/"

  log_info "Cloning wallpapers repo..."
  git clone --depth 1 https://github.com/tyvren/hyprnosis-wallpapers.git /tmp/wallpapers
  log_info "Copying wallpapers..."
  cp -r /tmp/wallpapers/. "$HOME/.config/hyprnosis/wallpapers/"
  rm -rf /tmp/wallpapers
  rm -rf "$HOME/.config/hyprnosis/wallpapers/.git"

  chmod +x "$HOME/.config/hyprnosis/modules/packages/"*
  chmod +x "$HOME/.config/hyprnosis/modules/style/"*
  chmod +x "$HOME/.config/hyprnosis/modules/updates/"*
  chmod +x "$HOME/.config/hyprnosis/modules/quickconfig/"*

  log_success "Configuration setup complete"
}

setup_quickconfig_alias() {
  SHELL_RC="$HOME/.bashrc"
  FUNCTION_NAME="config"
  SCRIPT_PATH="$HOME/.config/hyprnosis/modules/quickconfig/quickconfig.sh"
  FUNCTION_DEF=$(
    cat <<EOF
# quickconfig CLI
$FUNCTION_NAME() {
    bash "$SCRIPT_PATH"
}
EOF
  )
  if ! grep -q "$FUNCTION_NAME()" "$SHELL_RC"; then
    echo "$FUNCTION_DEF" >>"$SHELL_RC"
    log_success "Alias function '$FUNCTION_NAME' added to $SHELL_RC"
  else
    log_info "Function '$FUNCTION_NAME' already exists in $SHELL_RC"
  fi
}
