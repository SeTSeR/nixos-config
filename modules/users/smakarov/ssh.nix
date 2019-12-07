{ pkgs, config, lib, ... }: {
  services.openssh = {
    enable = config.deviceSpecific.isWorkMachine;
    passwordAuthentication = false;
  };

  users.users.smakarov.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFF91VkQuL4q43fcg5MceqDNsSQVJar0EDTOsOnqv8UzZqd1+rUOZargYsSaPA1ueobEaRO8oLgBLWvHIJkhbTlSBvO/Yvv+wyCnfkxwWnwH3ba8y6zq9HylrchFUbaHhcAYq19im3G15+E7H5FllRLW4RQl5GGKZbuc4So5E33x/sV/WeunwL+KXuFIYu85IyZuep5uAHx1RleA3Yx7Ja6t3xsrea5y2w4lrbaqigivpA0EwHAgOUqH8vcfLf6AmpVT/LMz8Iuc9Fj+kyxGderlke93M9ftpVIASgJXKUEYWpVYp5RfPj/LmSnAqAC2LE4wPo/WEGJsqVOa+gXAJZJMdMA+VOR7mTl9oNP+nj8KAIvdv2C0ZJZiJTQ1GnXWbR4cHS6q6z3gy7/ToN8Wbzzl63SdkxW+r1XD3H9R1P1E2+bevMacwRTG0TzkpKs6aKVrjQjvGuRUZU2RCCv0TEzqxUtDSPzEs0n2idCL8TAmIx0HhOJu3t3PBR0NLr81zESf+YoZ0HS/C09qkcL5uI8dtJ5voRszUsojf6wmrhnzm2AlITybgmwexmyqEzvp1yR8Q5n74HnRV702nSQLzR6/P3DDDV/5IW9MUkrspQBnptR9rolxl6pYNtRN5siUW8YzTvuB6rbj/wH8HeBu7TVKoj3S+vP3danESIzEK5Ww== setser200018@gmail.com"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKHRdBZ726XSag0n9M7sbvaKzP5RsgExBX6pZEHqbSC+JY5HPXG41wNATZrFGGXPqxAY98k5FEos45fcyA5OfeTcRm7Yz6gUGpvl61JfYsYyI4ZxyfAcofrPyEJo6VXGHCMdLeGtvhWCOZf/MtlQWnGLX4KmMFQ27r6Y3zpFmDHA/ehUXwdXZ2u5kQpyc6rNlJmROY0NbPfby2s6bN/lF5geI6uLQLWJAUBwBU1JIIpGDGikeL6skbQNQqxJaYehuwHmlkWQlRRza+tLz8Wvgjs/SerSstM7o/w4PAVdClnqWDyEfNbV66JkYNEzREXD8JQeV0lOwAIec0Jpo9uwbHc1vEiXQJWix15vBYLeK0FWdEtJNpvcIaLcxBqqR76mGfe/KqLpU2GLl50fUVzU465rZdaG3JkamKvzA5eSv9iMYcrnwYqs0Cy4/cTye89rF7TLAqnGhT14VZaBPymEJc15iiCSA9f2pZuCh9ABo3eoN6ef8PpV29DsYzuGwnXG8hGDBIzN3IGv8+COdx7+hoSF3JR+w9WJo2DaNyJ6Z6uu0vk/scAuZG1SMm+QekrsWbdc1g8P7/mgqXTMyZgUPLg9OLChJj8dxKeljIW/hjRThBhmQZkmo4felAi78P2pDwi9LklENwYYJHY7+NDScFMz7EltIAniB3QujyiAJNVQ== smakarov@ispras.ru"
  ];

  home-manager.users.smakarov.programs.ssh = {
    enable = true;
    matchBlocks = {
      "polus" = {
        hostname = "polus.hpc.cs.msu.ru";
        user = "edu-cmc-skpod19-327-07";
        identityFile = "/home/smakarov/.ssh/edu-cmc-skpod19-327-07";
      };
      "bluegene" = {
        hostname = "bluegene.hpc.cs.msu.ru";
        user = "edu-cmc-skpod19-327-07";
        identityFile = "/home/smakarov/.ssh/edu-cmc-skpod19-327-07";
      };
      "work" = {
        hostname = "10.10.156.56";
        user = "smakarov";
        identityFile = toString (pkgs.writeTextFile {
          name = "id_rsa";
          text = config.secrets.id_rsa;
        });
        compression = false;
      };
    };
  };
}
