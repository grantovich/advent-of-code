# --- Day 19: Medicine for Rudolph ---

require 'strscan'

class Day19
  def initialize(molecule:, replacements:)
    @molecule = molecule
    @replacements = replacements.each_line.map do |line|
      line.chomp.split(' => ')
    end
  end

  def distinct_molecules
    [].tap do |molecules|
      scanner = StringScanner.new(@molecule)

      @replacements.each do |(source, target)|
        scanner.reset
        source_pattern = Regexp.new(source)

        loop do
          scanner.scan_until(source_pattern)

          if scanner.matched?
            result = @molecule.dup
            result[scanner.pre_match.size, source.size] = target
            molecules << result
          else
            break
          end
        end
      end
    end.uniq
  end

  def minimal_steps_from(initial_molecule)
    steps = [@molecule]
    replacements = @replacements
      .map(&:reverse)
      .sort_by do |(from, to)|
        from.scan(/[A-Z][a-z]*/).size - to.scan(/[A-Z][a-z]*/).size
      end
      .reverse

    loop do
      from_sequence, to_sequence = replacements.find do |(from_sequence, _)|
        steps.last.include?(from_sequence)
      end

      steps << steps.last.sub(/(.*)#{from_sequence}/, "\\1#{to_sequence}")

      return steps[1..-1] if steps.last == initial_molecule
    end
  end
end
