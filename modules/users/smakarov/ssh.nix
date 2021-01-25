{ pkgs, config, lib, ... }: {
  services.openssh = {
    enable = config.deviceSpecific.isWorkMachine;
    forwardX11 = true;
    passwordAuthentication = false;
  };

  programs.ssh.startAgent = false;

  users.users.smakarov.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFF91VkQuL4q43fcg5MceqDNsSQVJar0EDTOsOnqv8UzZqd1+rUOZargYsSaPA1ueobEaRO8oLgBLWvHIJkhbTlSBvO/Yvv+wyCnfkxwWnwH3ba8y6zq9HylrchFUbaHhcAYq19im3G15+E7H5FllRLW4RQl5GGKZbuc4So5E33x/sV/WeunwL+KXuFIYu85IyZuep5uAHx1RleA3Yx7Ja6t3xsrea5y2w4lrbaqigivpA0EwHAgOUqH8vcfLf6AmpVT/LMz8Iuc9Fj+kyxGderlke93M9ftpVIASgJXKUEYWpVYp5RfPj/LmSnAqAC2LE4wPo/WEGJsqVOa+gXAJZJMdMA+VOR7mTl9oNP+nj8KAIvdv2C0ZJZiJTQ1GnXWbR4cHS6q6z3gy7/ToN8Wbzzl63SdkxW+r1XD3H9R1P1E2+bevMacwRTG0TzkpKs6aKVrjQjvGuRUZU2RCCv0TEzqxUtDSPzEs0n2idCL8TAmIx0HhOJu3t3PBR0NLr81zESf+YoZ0HS/C09qkcL5uI8dtJ5voRszUsojf6wmrhnzm2AlITybgmwexmyqEzvp1yR8Q5n74HnRV702nSQLzR6/P3DDDV/5IW9MUkrspQBnptR9rolxl6pYNtRN5siUW8YzTvuB6rbj/wH8HeBu7TVKoj3S+vP3danESIzEK5Ww== setser200018@gmail.com"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKHRdBZ726XSag0n9M7sbvaKzP5RsgExBX6pZEHqbSC+JY5HPXG41wNATZrFGGXPqxAY98k5FEos45fcyA5OfeTcRm7Yz6gUGpvl61JfYsYyI4ZxyfAcofrPyEJo6VXGHCMdLeGtvhWCOZf/MtlQWnGLX4KmMFQ27r6Y3zpFmDHA/ehUXwdXZ2u5kQpyc6rNlJmROY0NbPfby2s6bN/lF5geI6uLQLWJAUBwBU1JIIpGDGikeL6skbQNQqxJaYehuwHmlkWQlRRza+tLz8Wvgjs/SerSstM7o/w4PAVdClnqWDyEfNbV66JkYNEzREXD8JQeV0lOwAIec0Jpo9uwbHc1vEiXQJWix15vBYLeK0FWdEtJNpvcIaLcxBqqR76mGfe/KqLpU2GLl50fUVzU465rZdaG3JkamKvzA5eSv9iMYcrnwYqs0Cy4/cTye89rF7TLAqnGhT14VZaBPymEJc15iiCSA9f2pZuCh9ABo3eoN6ef8PpV29DsYzuGwnXG8hGDBIzN3IGv8+COdx7+hoSF3JR+w9WJo2DaNyJ6Z6uu0vk/scAuZG1SMm+QekrsWbdc1g8P7/mgqXTMyZgUPLg9OLChJj8dxKeljIW/hjRThBhmQZkmo4felAi78P2pDwi9LklENwYYJHY7+NDScFMz7EltIAniB3QujyiAJNVQ== smakarov@ispras.ru"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFWzAmNmL+V17HBh70DqgRY359e3n2a4tJXgOW3p4VR858sEf0M1k2kKe052Q/WMaaYL0qc/gzYueho/2KnNTURQOUPnIFxZJ4Q1hcYRn7Mr1DmwH3Bbe3+T8HnfAU28ZovOZMZXGRYJzRW+WbNMBhX9IXKy4wAvZxdQwfUcVHHf3jrcMdJDbDV7B9I+KLufun4YdyknQyHQ7+4aoIaxM2H89m54wRS5h0iZOXFub5Ndc6N1xmkHr4CDzACbyZr6/p8i668vkPfNL+uGhR7hNB5NuPFmAgTJpGPgGQLT4WAY5qnBHNglB5l9nMysnfuKgGcT7A52Vqriq0u8E2KgBVsK1PweViqX2Sr+FaQ69MBg5G/gjjVrSPxrYsp7n53937X1xs7DsKg+0TmXY3UYbDiH8s6oqGSh4Mt1Sl4fbcpiqA5YcYWbK4Xl7XcvjfY9oRh8KH2nTRiTyI3gKeqk2DuT3e3mBNmeIsF2cUG0Y3qjDlklxmZXrSjy4kESOUIraRjRB/Xky7wKVGpTqHvT84jhWMBmg+nqnH9BpN42qN1PKWqIQMhE6+gzfJiwaHI8PQhGhieVxvBTS3MnTdf5G6QvjW+CQmH9mBxSgLIrsjQ7WrbJmiiL9uHLr+RGwRuUNBBqHZ/RW7bt8W+TTaWcUnsUdcJaIh5W7vIYI8kfeNew== openpgp:0x6AD6E4F9"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEshBJwPCo2R8UKURcFzUeV1nOZY4S1V0mAsaPhxazkHhuKVe/rkKUsWDmQsKQqg3F2Y3kmABtOfIj08CDhUxvjSOh1srnalCb3AaRq5uOxZXhUiZBzFz0UIzLAcCtP54vKAie/op1n/FrdpBIAkPJJzCGx/1duM7S0RfNouKu9Fck9sr+G0BuSzwcOfdxXB8v/Qysfosj6FlrfzGUPklnMyv3dqdYbnKlx+TD656lAS2oGnvQ8jNnyy4WFsc3Bf8YYii3zk4D/SBoA4RNEFIzyG5XXyUQZR2NAIDn7n6iuq893TshdVWFX2gljVI50ZbqDDJDAo+J0tl+H1J1bgRh96W+2dvS02wnMT90hfCjDi3+lvPnTxoaGEZvZdj18/OSu6H+o9lIXesXQXU+pmAbmj5xx6Y86CHA/pfOrBztmGWIbyDpB8sJzEtTg+CnQaHYHGFySt0lHYSqtfOUZUgH8SwPDh89OYRkcAc/BYzXy68/6678V4pbKRcHvOR9uytsPkHUw8+UDEL7ULwuPfPxaqIv6oynj783uk6nhbqtwQr+PfHUgnBCr16/aOOJKxSxk7Vr5wOVP6kvpKomTedgjqU4kny7AVAIbH40bJZjlI/uJYqQCrL9hc375mJNxsUEuslwLSwwFHea18ynwXHgso9MKT7PdOHZVY9KPw5JBw== smakarov@ispras.ru
"
  ];

  home-manager.users.smakarov.programs.ssh = {
    enable = true;
    matchBlocks = {
      "work" = {
        hostname = "10.10.156.56";
        user = "smakarov";
        compression = false;
        forwardAgent = true;
        serverAliveCountMax = 30;
        serverAliveInterval = 5;
      };
    };
  };

  programs.mosh.enable = true;
}
