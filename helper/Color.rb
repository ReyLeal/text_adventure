module ColorModule

  def self.red(content)
    puts "\e[31m#{content}\e[0m"
  end

  def self.green(content)
    puts "\e[32m#{content}\e[0m"
  end

  def self.blue(content)
    puts "\e[34m#{content}\e[0m"
  end

end
