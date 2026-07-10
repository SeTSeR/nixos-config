self: super: {
  tdlib = super.tdlib.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "1.8.63";

      src = super.fetchFromGitHub {
        owner = "tdlib";
        repo = "td";

        # The tdlib authors do not set tags for minor versions, but
        # external programs depending on tdlib constrain the minor
        # version, hence we set a specific commit with a known version.
        rev = "f06b0bac65278b03d26414c096080e7bfecfef52";
        hash = "sha256-SzUDAZqdEIrIj1qUUD0MvzbCYxKLJwoX2+T0chud/rQ=";
      };
    }
  );
}
