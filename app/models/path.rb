class Path

  def self.db_file_path(file_name)
    File.join(Rails.root, "db", file_name)
  end

  # todo: test
  def self.from_csv f = db_file_path("paths.csv")
    rows = CSV.read(f, headers: :first_row)
    paths = rows.map do |row|
      team = row["team"]
      role = row["role"]
      point_cells = (0..9).map do |i|
        row["point#{i}"]
      end.compact
      points = point_cells.map do |cell|
        Point.from_a(cell.split(',').map(&:to_f))
      end.compact
      Path.new(team: team, role: role, points: points)
    end
    paths
  end

  def self.all
    from_csv
  end

  def self.where(team: nil, role: nil)
    all.select do |path|
      (team.nil? or path.team == team) and (role.nil? or path.role == role)
    end
  end

  attr_reader :team, :role, :points, :count, :active

  def initialize(team:, role:, points:, count: 0, active: true)
    @team = team
    @role = role
    @points = points
    @count = count
    @active = active
  end

  def ==(other)
    other.is_a? Path and
      other.team == self.team and
      other.role == self.role and
      other.points == self.points
  end

  # for export to gdoc sheet
  def to_row
    [@team, @role] + @points.map { |p| p.to_a.join(',') }
  end

  def serializable_hash(options=nil)
    {
      team: @team,
      role: @role,
      count: @count,
      active: @active,
      points: @points.map(&:as_json),
    }.deep_stringify_keys
  end

  def point
    raise "can't get a single point from an offense path" if @role == 'offense'
    @points.first
  end

  def increment_count
    @count += 1
  end

end
