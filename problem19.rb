# You are given the following information, but you may prefer to do some research for yourself.

    # * 1 Jan 1900 was a Monday.
    # * Thirty days has September,
      # April, June and November.
      # All the rest have thirty-one,
      # Saving February alone,
      # Which has twenty-eight, rain or shine.
      # And on leap years, twenty-nine.
    # * A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
require 'common'
days = [31,28,31,30,31,30,31,31,30,31,30,31]
counter = 0
current_day = (1+365) % 7 #1 jan 1901
100.times do |year|
	12.times do |month|
		counter += 1 if current_day == 0
		current_day = current_day + days[month] + ((month == 1 and (year+1) % 4 == 0)?(1):(0))
		current_day = current_day % 7
	end
end

puts counter