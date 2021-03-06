# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: multicash 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "multicash"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Anton Yordanov"]
  s.date = "2014-02-07"
  s.description = "Generate payment order under the multicash spec"
  s.email = "anton.yordnaov@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/multicash.rb",
    "lib/multicash/account.rb",
    "lib/multicash/ammount.rb",
    "lib/multicash/credit_transfer.rb",
    "lib/multicash/labels/credit_transfer.rb",
    "lib/multicash/labels/payment_order.rb",
    "lib/multicash/payment.rb",
    "lib/multicash/payment_order.rb",
    "lib/multicash/transfer.rb",
    "lib/multicash/transfer_labels_builder.rb",
    "lib/multicash/utils.rb",
    "multicash.gemspec",
    "spec/account_spec.rb",
    "spec/ammount_spec.rb",
    "spec/credit_transfer_spec.rb",
    "spec/fixtures/transfer.yml",
    "spec/labels/credit_transfer_spec.rb",
    "spec/payment_order_spec.rb",
    "spec/payment_spec.rb",
    "spec/spec_helper.rb",
    "spec/transfer_spec.rb"
  ]
  s.homepage = "http://github.com/anotin-yordanov/multicash"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.12"
  s.summary = "Generate payment order under the multicash spec"

  if s.respond_to? :specification_version then
    s.specification_version = 5

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["> 4.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, ["> 4.0.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["> 4.0.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

