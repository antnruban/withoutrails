# frozen_string_literal: true

require 'json'

run ->(_) { [200, { 'Content-Type' => 'application/json' }, [{ msg: 'Hello World!' }.to_json]] }
