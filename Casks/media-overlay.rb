cask "media-overlay" do
  version "0.2.0"
  sha256 "5dfdacfd6f6707d184eba07132a4842e870ba0f3e74fbfe63f3f94e486b47d4f"

  url "https://github.com/dionatanlaranjeira/media-overlay-releases/releases/download/v#{version}/MediaOverlay-#{version}.zip"
  name "Media Overlay"
  desc "Overlay de mídia, timer e bateria para a barra de menus"
  homepage "https://github.com/dionatanlaranjeira/media-overlay-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "MediaOverlay.app"

  # O app não é notarizado: sem tirar a quarentena, o Gatekeeper bloqueia a abertura.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MediaOverlay.app"]
  end

  uninstall quit: "com.dionatan.media-overlay"

  zap trash: "~/Library/Preferences/com.dionatan.media-overlay.plist"

  caveats <<~EOS
    Na primeira vez, aceite quando o macOS pedir para controlar o Spotify e o Chrome.
    No Chrome, ative Ver > Desenvolvedor > "Permitir o JavaScript do Eventos da Apple"
    para o YouTube Music funcionar.
  EOS
end
