1. Input data is utf8 encoded
2. mochijson / erlang natively supports latin1
3. Use unicode:characters_to_binary/3 to convert to binary with utf8 as the in scheme and latin1 as the out
4. Use mochijson with utf8 encoder option set to true
5. win
