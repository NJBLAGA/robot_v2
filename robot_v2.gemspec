# frozen_string_literal: true

require_relative "lib/robot_v2/version"

Gem::Specification.new do |spec|
  spec.name          = "robot_v2"
  spec.version       = RobotV2::VERSION
  spec.authors       = ["NJBLAGA"]
  spec.email         = ["nathanblaga90@gmail.com"]

  spec.summary       = "The application is a simulation of a toy robot moving on a square tabletop."
  spec.homepage      = "https://github.com/NJBLAGA/robot_v2.git"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.2"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/NJBLAGA/robot_v2.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
