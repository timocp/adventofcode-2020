class Day8 < Base
  def part1
    vm = VM.new(raw_input)
    vm.terminates? # we know it doesn't
    vm.accumulator
  end

  def part2
    vm = VM.new(raw_input)
    vm.program.map(&:op).each.with_index.reject { |op, _i| op == :acc }.each do |orig_op, i|
      new_op = orig_op == :nop ? :jmp : :nop
      vm.program[i].op = new_op
      return vm.accumulator if vm.terminates?
      vm.program[i].op = orig_op
    end
    "Never terminates"
  end

  class VM
    def initialize(text)
      @program = parse_program(text)
    end

    attr_reader :accumulator, :pc, :program

    Instruction = Struct.new(:op, :arg)

    def run_until(&block)
      while instruction
        return false if yield

        case instruction.op
        when :nop then nop
        when :acc then acc(instruction.arg)
        when :jmp then jmp(instruction.arg)
        else
          raise "Unhandled opcode: #{instruction.op}"
        end
      end
      true
    end

    def terminates?
      reset
      seen = {}
      run_until do
        if seen[pc]
          true
        else
          seen[pc] = true
          false
        end
      end
    end

    def reset
      @accumulator = 0
      @pc = 0
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
      @pc += 1
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
