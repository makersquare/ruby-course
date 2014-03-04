require 'ruby_parser'
require 'sexp_path'
require './review.rb'

RSpec.configure do |c|
  # FOR THE CURIOUS: This is the line we alias `you` to `it`
  c.alias_example_to :you
  c.alias_example_to :xyou, :pending => true
end

construct_message = Proc.new do |msg|
  msg += " in `#{@class}`" if @class
  msg += " in method `#{@method}`" if @method
  msg += " in class method `#{@class_method}`" if @class_method
  msg += " for #{@module}" if @module
  msg += " with exactly #{@line_count} line#{'s' if @line_count != 1}" if @line_count
  @msg = msg
end

RSpec::Matchers.define :include_code do |word|
  match do |source|
    m = @module
    c = @class
    method = @method
    class_method = @class_method
    result = source

    result = result / Q?{ s(:module, m, ___) } if m
    result = result / Q?{ s(:class, c, ___) } if c
    result = result / Q?{ s(:defn, method, ___) } if method
    result = result / Q?{ s(:defs, s(:self), class_method, ___) } if class_method
    result = result / Q?{ include(word) }

    result.any?
  end

  chain :in do |class_name|
    @class = class_name
  end

  chain :in_method do |method_name|
    @method = method_name
  end

  chain :in_class_method do |class_name, class_method_name=nil|
    if class_method_name.nil?
      @class_method = class_name
    else
      @class = class_name
      @class_method = class_method_name
    end
  end

  chain :for do |module_name|
    @module = module_name
  end

  failure_message_for_should do |source|
    self.instance_exec "expected your code to include `#{word}`", &construct_message
    @msg
  end
  failure_message_for_should_not do |source|
    self.instance_exec "expected your code to not include `#{word}`", &construct_message
    @msg
  end
  description do
    self.instance_exec "include `#{word}`", &construct_message
    @msg
  end
end

RSpec::Matchers.define :include_method do |method_name|
  match do |source|
    m = @module
    c = @class
    result = source

    result = result / Q?{ s(:module, m, ___) } if m
    result = result / Q?{ s(:class, c, ___) } if c
    result = result / Q?{ s(:defn, method_name, ___) }

    if @line_count
      result.any? && result.first.sexp[3..-1].count == @line_count
    else
      result.any?
    end
  end

  chain :in do |class_name|
    @class = class_name
  end

  chain :for do |module_name|
    @module = module_name
  end

  chain :with_line_count do |count|
    @line_count = count
  end

  failure_message_for_should do |source|
    self.instance_exec "expected your code to include the method `#{method_name}`", &construct_message
    @msg
  end
  failure_message_for_should_not do |source|
    self.instance_exec "expected your code to not include the method `#{method_name}`", &construct_message
    @msg
  end
  description do
    self.instance_exec "include method `#{method_name}`", &construct_message
    @msg
  end
end

RSpec::Matchers.define :include_class_method do |class_name, method_name|
  @class = class_name

  match do |source|
    m = @module
    result = source

    result = result / Q?{ s(:module, m, ___) } if m
    result = result / Q?{ s(:class, class_name, ___) }
    result = result / Q?{ s(:defs, s(:self), method_name, ___) }

    if @line_count
      result.any? && result.first.sexp[4..-1].count == @line_count
    else
      result.any?
    end
  end

  chain :for do |module_name|
    @module = module_name
  end

  chain :with_line_count do |count|
    @line_count = count
  end

  failure_message_for_should do |source|
    self.instance_exec "expected your code to include the class method `#{method_name}`", &construct_message
    @msg
  end
  failure_message_for_should_not do |source|
    self.instance_exec "expected your code to not include the class method `#{method_name}`", &construct_message
    @msg
  end
  description do
    self.instance_exec "include class method `#{method_name}`", &construct_message
    @msg
  end
end

RSpec::Matchers.define :include_method_call do |method_name, *args|
  def sval(val)
    type = case val
    when Symbol, Integer then :lit
    when String then :str
    end
    s(type, val)
  end

  match do |source|
    m = @module
    c = @class
    s_args = args.map {|v| sval(v) }
    result = source

    result = result / Q?{ s(:module, m, ___) } if m
    result = result / Q?{ s(:class, c, ___) } if c
    result = result / Q?{ s(:call, nil, method_name, *s_args) }

    result.any?
  end

  chain :in do |class_name|
    @class = class_name
  end

  chain :for do |module_name|
    @module = module_name
  end

  failure_message_for_should do |source|
    pretty_args = args.map(&:inspect).join(',')
    msg = "expected your code to include the method call `#{method_name}(#{pretty_args})`"
    self.instance_exec msg, &construct_message
    @msg
  end
  failure_message_for_should_not do |source|
    pretty_args = args.map(&:inspect).join(',')
    msg = "expected your code to not include the method call `#{method_name}(#{pretty_args})`"
    self.instance_exec msg, &construct_message
    @msg
  end
  description do
    pretty_args = args.map(&:inspect).join(',')
    msg = "include a method call `#{method_name}`(#{pretty_args})"
    self.instance_exec msg, &construct_message
    @msg
  end
end
