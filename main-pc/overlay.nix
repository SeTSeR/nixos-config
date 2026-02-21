self: super: {
  kmscon = super.kmscon.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "9.3.2";

      src = super.fetchFromGitHub {
        owner = "kmscon";
        repo = "kmscon";
        tag = "v${finalAttrs.version}";
        hash = "sha256-a1H9/j92Z/vjvFp226Ps9PFy5dAS8yg+RErgJWIb9HQ=";
      };
    }
  );
}
