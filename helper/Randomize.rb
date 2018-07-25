module RandomizeModule

  def self.randomizeStats(min, max = min)
    random = Random.new;
    return random.rand(min..max)
  end

end
