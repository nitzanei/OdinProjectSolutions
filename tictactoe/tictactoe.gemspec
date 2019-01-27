# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "tictactoe"
  spec.version       = '1.0'
  spec.authors       = ["Nitzan Eini"]
  spec.email         = ["nitzan.eini@gmail.com"]
  spec.summary       = %q{tic tac toe game}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "MIT"

  spec.files         = ['lib/tictactoe.rb']
  spec.executables   = ['bin/tictactoe']
  spec.test_files    = ['tests/test_tictactoe.rb']
  spec.require_paths = ["lib"]
end
