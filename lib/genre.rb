class Genre
  extend Concerns::Findable

  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
    self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Genre.new(name).save
  end

  def add_song(instance_of_song)
    @songs << instance_of_song if !@songs.include?(instance_of_song)
    instance_of_song.genre = self if !instance_of_song.genre
  end

  def songs
    @songs
  end

  def artists
    @songs.map(&:artist).uniq
  end
end
