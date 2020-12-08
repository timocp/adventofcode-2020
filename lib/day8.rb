class Day8 < Base
  def part1
    seen = {} # key of instructions that have already executed
    VM.new(raw_input).tap do |vm|
      vm.run_until do
        if seen[vm.pc]
          true
        else
          seen[vm.pc] = true
          false
        end
      end
    end.accumulator
  end

  class VM
    def initialize(text)
      @program = parse_program(text)
      @accumulator = 0
      @pc = 0
    end

    attr_reader :accumulator, :pc

    Instruction = Struct.new(:op, :arg)

    def run_until(&block)
      loop do
        return if yield

        case instruction.op
        when :nop then nop
        when :acc then acc(instruction.arg)
        when :jmp then jmp(instruction.arg)
        else
          raise "Unhandled opcode: #{instruction.op}"
        end
      end
    end

    private

    def parse_program(text)
      text.each_line.map(&:split).map do |line|
        Instruction.new(line[0].to_sym, line[1].to_i)
      end
    end

    def instruction
      @program[@pc]
    end

    def increment_pc
      @pc = (@pc + 1 % @program.size)
    end

    def nop
      increment_pc
    end

    def acc(arg)
      @accumulator += arg
      increment_pc
    end

    def jmp(arg)
      @pc += arg
    end
  end
end
