# Script to capture repeated terminal output from tic tac toe program for stress testing and bug checking

require 'stringio'

stdout = StringIO.new
$stdout = stdout

100.times { load 'main.rb' }
File.open("stress_test_3.txt", 'w') { |file| file.write(stdout.string) }