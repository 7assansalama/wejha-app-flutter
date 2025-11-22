{ pkgs, ... }: {
  # Change to a more recent channel to get a newer Flutter/Dart SDK
  channel = "unstable"; 

  packages = [
    pkgs.flutter
    pkgs.jdk17 
    pkgs.unzip
    pkgs.zip
    pkgs.clang
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config
    pkgs.gtk3
  ];

  # Environment variables
  env = {};

  idx = {
    # Necessary VS Code extensions
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    # Workspace startup commands
    workspace = {
      onStart = {
        # Enable web and android, and set up dependencies
        init-flutter = "flutter pub get";
        doctor = "flutter doctor";
      };
    };

    # Preview settings
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
          manager = "flutter";
        };
        android = {
          command = ["flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555"];
          manager = "flutter";
        };
      };
    };
  };
}