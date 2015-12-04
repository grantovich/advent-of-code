# --- Day 3: Perfectly Spherical Houses in a Vacuum ---

class Day3
  def initialize(directions)
    @directions = directions
  end

  def visited_houses(santas: 1)
    houses = Hash.new{ |hash, key| hash[key] = Hash.new(0) }
    positions = Array.new(santas){ { x: 0, y: 0 } }
    houses[0][0] = 1

    @directions.each_char.with_index do |direction, index|
      position = positions[index % santas]

      case direction
      when '^' then position[:y] -= 1
      when 'v' then position[:y] += 1
      when '<' then position[:x] -= 1
      when '>' then position[:x] += 1
      end

      houses[position[:y]][position[:x]] += 1
    end

    houses.values.flat_map(&:values).count
  end
end
