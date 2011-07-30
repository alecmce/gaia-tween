require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'rake/clean'
require 'flashsdk'
require 'asunit4'

##
# Set USE_FCSH to true in order to use FCSH for all compile tasks.
#
# You can also set this value by calling the :fcsh task 
# manually like:
#
#   rake fcsh run
#
# These values can also be sent from the command line like:
#
#   rake run FCSH_PKG_NAME=flex3
#
# ENV['USE_FCSH']         = true
# ENV['FCSH_PKG_NAME']    = 'flex4'
# ENV['FCSH_PKG_VERSION'] = '1.0.14.pre'
# ENV['FCSH_PORT']        = 12321

##############################
# Test

# Compile the test swf
mxmlc "bin/tests.swf" => :asunit4 do |t|
  t.input = "test/TestRunner.as"
  t.source_path << 'src'
  t.source_path << 'test'
  t.library_path << 'libs/AsUnit-4.2.3.pre.swc'
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "bin/tests.swf"

##############################
# SWC

compc "bin/gaia-tween.swc" do |t|
  t.include_sources << 'src'
end

desc "Compile the SWC file"
task :swc => 'bin/gaia-tween.swc'

##############################
# DOC

desc "Generate documentation at doc/"
asdoc 'doc' do |t|
  t.doc_sources << "src"
  t.exclude_sources << "test"
end

##############################
# DEFAULT
task :default => :test
