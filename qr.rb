require "mathn"
class Array
	def sum()
		self.inject 0, &:+
	end

	def copy()
		Array.new(self.size){|i| Array.new(self.size){|j| self[i][j]}}	
	end
end

def kron(i, j)
	if i == j then 1 else 0 end
end

def sign(x)
	if x >= 0 then 1 else -1 end
end

n = 3
a = [
	[6.03, 13, -17],
	[13, 29.03, -38],
	[-17, -38, 50.03]
]
v_p = Matrix.I(n)

for k in (0...n)
	t_p = Array.new(n) do |j|
		if j == k
			a[k][k] + sign(a[k][k]) * Math.sqrt(Array.new(n - j){|l| a[j + l][k] ** 2}.sum)
		else
			if j > k
				a[j][k]
			else
				0
			end
		end
	end

	b = a.copy
	b[k][k] = -sign(a[k][k]) * Math.sqrt(Array.new(n){|l| a[l][k] ** 2}.sum)
	for i in (k + 1...n)
		b[i][k] = 0
	end
	sum2 = Array.new(n){|l| t_p[l] ** 2}.sum
	p sum2
	for i in (k...n)
		for j in (k + 1...n)
			sum1 = Array.new(n){|l| t_p[l] * a[l][j]}.sum
			b[i][j] = a[i][j] - 2 * t_p[i] * sum1 / sum2
		end
	end
	a = b.copy	
end