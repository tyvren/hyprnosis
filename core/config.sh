config_setup() {
  log_info "Copying Somnium theme files..."
  cp -r "$HOME/.config/somnium/themes/Somnium/." "$HOME/.config/"

  log_info "Copying config files..."
  cp -r "$HOME/.config/somnium/config/"* "$HOME/.config/"

  log_info "Cloning wallpapers repo..."
  git clone --depth 1 https://github.com/tyvren/somnium-wallpapers.git /tmp/wallpapers
  log_info "Copying wallpapers..."
  rm -rf /tmp/wallpapers/.git
  rm -rf /tmp/wallpapers/README.md
  cp -r /tmp/wallpapers/. "$INSTALL_DIR/wallpapers/"
  rm -rf /tmp/wallpapers

  chmod +x "$HOME/.config/somnium/modules/diskmanagement/"*
  chmod +x "$HOME/.config/somnium/modules/packages/"*
  chmod +x "$HOME/.config/somnium/modules/quickconfig/"*
  chmod +x "$HOME/.config/somnium/modules/quickshell/"*
  chmod +x "$HOME/.config/somnium/modules/style/"*
  chmod +x "$HOME/.config/somnium/modules/updates/"*

  log_success "Configuration setup complete"
}

setup_quickconfig_alias() {
  SHELL_RC="$HOME/.bashrc"
  FUNCTION_NAME="config"
  SCRIPT_PATH="$HOME/.config/somnium/modules/quickconfig/quickconfig.sh"
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
