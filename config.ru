require 'json'

run->_env { [200, {'Content-Type' => 'application/json'}, [{msg: 'Hello World!'}.to_json]] }
