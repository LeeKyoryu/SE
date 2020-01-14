# 练习1

reg1=/hay/ =~ 'haystack' # 若匹配成功则返回匹配部分的首位置(从0起始)，若匹配失败则返回nil
reg2=/y/.match('ayayayay') # 若匹配成功则返回模式式，若匹配失败则返回nil

puts reg1
puts reg2

# 练习2

class Class # 利用元编程的思想，给基类Class增补一些方法
  alias old_new new # 把原始基类的初始化方法(在本次增补过程内)new更名为old_new，防止被新定义的new方法覆盖，并且还要在new中被使用
  def new(*args) # 新定义new方法覆盖原始的new(本例中，在用new实例化之前打印信息)
    print "Creating a new ", self.name, "\n"
    old_new(*args)
  end
end

class MyName
end

MyName.new # new方法已被修改

# 练习3

class Interpreter
  def do_a()
    print "there, "
  end
  def do_d()
    print "Hello "
  end
  def do_e()
    print "!\n"
  end
  def do_v()
    print "Dave"
  end
  Dispatcher = { # 分发器
    "a" => instance_method(:do_a),
    "d" => instance_method(:do_d),
    "e" => instance_method(:do_e),
    "v" => instance_method(:do_v),
  }
  def interpret(string) # 集线器方法
    string.each_char{|b| Dispatcher[b].bind(self).call}
  end
end

interpreter = Interpreter.new
interpreter.interpret('dave')

# 练习4

a = 0
a += 1 if a.zero?
p a

a = 0
a += 1 unless a.zero?
p a

# 练习5

selected = []
0.upto 5 do |value|
  selected << value if value==2..value==2 # (value==2)..(value==2)
end
p selected

selected = []
0.upto 5 do |value|
  selected << value if value==2...value==2 # (value==2)...(value==2)
end
p selected

# 练习6

class MegaGreeter
  attr_accessor :names
  def initialize(names = "World")
    @names = names
  end
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end
end

class Calculator
	def multiply(x, y)
		x*y
	end
	def divide(x, y)
		x/y
	end
end
class TestCalculator
	def test_add
		calc = Calculator.new
		assert calc.add(5, 2) == 7
	end
	def test_subtract
		calc = Calculator.new
		assert calc.subtract(5, 2) == 3
	end
	def test_multiplication
		calc = Calculator.new
		assert calc.multiplication(5, 2) == 10
	end
	def test_division
		calc = Calculator.new 
		assert calc.division(5, 2) == 2
	end
end

def fib n
	base_1 = (1 + 5**(0.5)) / 2
	base_2 = (1 - 5**(0.5)) / 2
	Integer( (base_1**n - base_2**n) / 5**(0.5) )
end
$i = 1
$max = 10
while $i < $max do
	n = fib $i
	puts n
	$i += 1
end

# 访问控制练习

class MyPublic
  def f1
    p self.my_protected # protected方法既可以在其他方法中以实例形式调用，又可以直接调用，因此可省略“self.”
    p my_private # private方法不能在其他方法中以实例形式调用，因此不能添加“self.”
  end
  protected
  def my_protected
    @protected = "protected!"
  end
  private
  def my_private
    @private = "private!"
  end
end

a = MyPublic.new
# p a.my_protected # 报错，不能外部调用
a.f1

cnt = []

1.upto(3) {cnt.push(1)}

puts cnt.join(",")