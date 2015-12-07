#!/usr/bin/env ruby
require 'xxhash'
#
# hashed_diff - Copyright Waag Society 2015 - 
# Taco van Dijk & Lodewijk Loos
#
# reasonably fast, memory efficient diff for very large files
#
# uses the very fast xxhash to create temporary files with hashes for each individual line
# applies diff to these hashed files
# transforms the diff output to include the original lines
# 
# Improvements: 
# speed doesn't seem to improve using two threads, 
# this because we're hitting io limits when hashing which degrades performance
#
exit(0) unless ARGV[0] && ARGV[1]

$old_file = ARGV[0]
$new_file = ARGV[1]

#diff regexps
$command = /(\d*,\d*|\d*)([cda])(\d*,\d*|\d*)/
$old_line = /< \d*/
$new_line = /> \d*/ 
$divider = /---/

# fills the original line arrays
def process(line)
	match = $command.match(line) 
	if(match)
	  collect_command(line,match)
	end
end

# output the processed lines
def output(line)
	match = $command.match(line) 
	if(match)
	  process_command(line,match)
	end

	if(match)
	  	puts line
	elsif($old_line =~ line)
		ln = $old_ln.shift
		puts "< #{$old_index[ln]}"
	elsif($new_line =~ line)
		ln = $new_ln.shift
		puts "> #{$new_index[ln]}"
	elsif($divider =~ line)
		puts line
	end	
end

#retrieve array of lines from a file by iterating
def retrieve_lines(path,lns)
	lines = []
	count = 1
	IO.foreach(path) { |line| 
		if(lns.include? count)
			lines << line
			lns.shift
		end
		count += 1
		break if (lns.count == 0)
	}
	return lines
end

#parse the line numbers to output 
def process_command(line,match)
	#get line numbers
	$old_ln = range_to_linenumbers(match[1]).flatten
	$new_ln = range_to_linenumbers(match[3]).flatten
end

#parse the line numbers to retrieve
def collect_command(line,match)
	#get line numbers
	$old_ln << range_to_linenumbers(match[1])
	$new_ln << range_to_linenumbers(match[3])
end

#convert diff range to array of line numbers
def range_to_linenumbers(range)
	return [range.to_i] unless range.split(',').length > 1 
	rstart, rend = range.split(',')
	ln = (rstart.to_i..rend.to_i).to_a
end

def hash_job(file)
	open("#{file}.hashed", 'a') { |f| IO.foreach(file) { |line| f << "#{XXhash.xxh32(line)}\n"}}
end

#create processes for both files
hash_job($old_file)
hash_job($new_file)

#diff the two hashed files
diff = `diff #{$old_file}.hashed #{$new_file}.hashed`

#arrays of linenumbers to retrieve for the current command
$old_ln = []
$new_ln = []

#process the diff line by line
diff.each_line do |line|
	process line
end

old_lines = retrieve_lines($old_file,$old_ln.flatten)
new_lines = retrieve_lines($new_file,$new_ln.flatten)

# index the lines for future reference
$old_index = Hash[$old_ln.flatten.zip(old_lines)]
$new_index = Hash[$new_ln.flatten.zip(new_lines)]

# output
diff.each_line do | line |
	output line
end

#clean up
`rm #{$old_file}.hashed`
`rm #{$new_file}.hashed`
