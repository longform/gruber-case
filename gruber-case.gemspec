# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gruber-case/version"

Gem::Specification.new do |s|
  s.name        = 'gruber-case'
  s.version     = GruberCase::VERSION
  s.date        = '2013-10-01'
  s.summary     = "Gruber Case"
  s.description = "A ruby port of John Gruber's Title Case algorithm"
  s.authors     = ["Benjamin Jackson"]
  s.email       = 'bhjackson@gmail.com'
  s.files       = ["lib/gruber-case.rb"]
  s.homepage    = 'https://github.com/longform/gruber-case'
  s.license     = 'MIT'
end