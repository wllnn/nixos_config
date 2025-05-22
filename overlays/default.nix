# overlays/default.nix
final: prev: {
  # 您可以在这里定义自定义包或覆盖现有包
  # 例如：
  # my-package = final.callPackage ./../pkgs/my-package { };
  # firefox = prev.firefox.overrideAttrs (old: {
  #   version = "126.0";
  #   src = final.fetchurl {
  #     url = "https://download.mozilla.org/?product=firefox-126.0-source&os=linux64&lang=en-US";
  #     sha256 = "sha256-hash-here";
  #   };
  # });
}