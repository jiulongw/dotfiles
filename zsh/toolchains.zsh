export_if_exists GOPATH "$HOME/go"
append_path "$GOPATH/bin"
append_path "/usr/local/go/bin"

source_if_exists "$HOME/.cargo/env"
append_path "$HOME/.cargo/bin"

export_if_exists ANDROID_HOME "$HOME/Library/Android/sdk"
export_if_exists ANDROID_HOME "$HOME/android/sdk"
export_if_exists NDK_ROOT "$ANDROID_HOME/ndk/25.2.9519653"
export_if_exists NDK_ROOT "$ANDROID_HOME/ndk/27.2.12479018"

append_path "$ANDROID_HOME/platform-tools"
append_path "$ANDROID_HOME/tools"
append_path "$ANDROID_HOME/cmdline-tools/latest/bin"
append_path "$NDK_ROOT"

export_if_exists NVM_DIR "$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh" 
source_if_exists "$NVM_DIR/bash_completion"

export_if_exists BUN_INSTALL "$HOME/.bun"
append_path "$BUN_INSTALL/bin"

prepend_path "/opt/homebrew/opt/ruby/bin"
append_path "$HOME/.gem/bin"

export_if_exists JAVA_HOME "/opt/homebrew/opt/openjdk"

append_path "$HOME/dev/depot_tools"
append_path "/opt/homebrew/opt/libpq/bin"
append_path "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"

export_if_exists PICO_SDK_PATH "$HOME/github/pico-sdk"

export_if_exists CLOUDSDK_PYTHON "/opt/homebrew/Cellar/python@3.14/3.14.10/bin/python3.14"
