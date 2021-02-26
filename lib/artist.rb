class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []

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
    Artist.new(name).save
  end

  def add_song(instance_of_song)
    @songs << instance_of_song if !@songs.include?(instance_of_song)
    instance_of_song.artist = self if instance_of_song.artist != self #assigns the current artist to the song's 'artist' property (song belongs to artist)
  end

  def songs
    @songs
  end

  def genres
    @songs.map(&:genre).uniq
  end
end
