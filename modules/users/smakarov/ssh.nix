{ pkgs, config, lib, ... }: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  users.users.smakarov.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFF91VkQuL4q43fcg5MceqDNsSQVJar0EDTOsOnqv8UzZqd1+rUOZargYsSaPA1ueobEaRO8oLgBLWvHIJkhbTlSBvO/Yvv+wyCnfkxwWnwH3ba8y6zq9HylrchFUbaHhcAYq19im3G15+E7H5FllRLW4RQl5GGKZbuc4So5E33x/sV/WeunwL+KXuFIYu85IyZuep5uAHx1RleA3Yx7Ja6t3xsrea5y2w4lrbaqigivpA0EwHAgOUqH8vcfLf6AmpVT/LMz8Iuc9Fj+kyxGderlke93M9ftpVIASgJXKUEYWpVYp5RfPj/LmSnAqAC2LE4wPo/WEGJsqVOa+gXAJZJMdMA+VOR7mTl9oNP+nj8KAIvdv2C0ZJZiJTQ1GnXWbR4cHS6q6z3gy7/ToN8Wbzzl63SdkxW+r1XD3H9R1P1E2+bevMacwRTG0TzkpKs6aKVrjQjvGuRUZU2RCCv0TEzqxUtDSPzEs0n2idCL8TAmIx0HhOJu3t3PBR0NLr81zESf+YoZ0HS/C09qkcL5uI8dtJ5voRszUsojf6wmrhnzm2AlITybgmwexmyqEzvp1yR8Q5n74HnRV702nSQLzR6/P3DDDV/5IW9MUkrspQBnptR9rolxl6pYNtRN5siUW8YzTvuB6rbj/wH8HeBu7TVKoj3S+vP3danESIzEK5Ww== setser200018@gmail.com"
  ];

  home-manager.users.smakarov.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityFile = toString (pkgs.writeTextFile {
          name = "id_rsa";
          text = config.secrets.id_rsa;
        });
        compression = false;
      };
    };
  };
}
