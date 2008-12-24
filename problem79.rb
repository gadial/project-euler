# A common security method used for online banking is to ask the user for three random characters from a passcode. For example, if the passcode was 531278, they may asked for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.

# The text file, keylog.txt, contains fifty successful login attempts.

# Given that the three characters are always asked for in order, analyse the file so as to determine the shortest possible secret passcode of unknown length.

require 'common'
class Array
	def legal_for?(login)
		reject{|x| not login.include?(x)} == login		
	end
end

logins=File.open("keylog.txt","r"){|file| file.read.split("\n").collect{|x| x.to_i.digits}}

candidates = [0,1,2,3,6,7,8,9].all_permutations
logins.each do |login|
	candidates.reject!{|x| not x.legal_for?(login)}
end

puts candidates.inspect
