require 'test/unit'
require 'common'

class IntegerTests < Test::Unit::TestCase
	def test_integer_sqrt
		assert_equal(9.integer_sqrt,3)
		assert_equal((54353**2).integer_sqrt,54353)
		assert_equal(13.integer_sqrt,nil)
	end
	def test_square?
		assert_equal(9.square?,true)
		assert_equal(8.square?,false)
		assert (3554654745747574**2).square?
	end
	def test_extended_gcd
		a,b = rand(10**6), rand(10**6)
		gcd, x, y = a.extended_gcd(b)
		assert_equal(gcd, a.gcd(b))
		assert_equal(a*x+b*y,gcd)
	end
end