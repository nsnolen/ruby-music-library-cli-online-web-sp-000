class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil) #can be invoked with an optional second/thir argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist)
    @name = name
    self.artist = artist if artist #returns the artist of the song (song belongs to artist) & invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
    self.genre = genre if genre # returns the genre of the song (song belongs to genre) along with adding it to attr of songs
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Song.new(name).save

  end

  def artist=(artist)   #assigns an artist to the song (song belongs to artist)
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)

      array = filename.gsub(/(\.mp3)/,'')
      array = array.split(" - ")
    artist = Artist.find_or_create_by_name(array[0])
    song = Song.find_or_create_by_name(array[1])
    genre = Genre.find_or_create_by_name(array[2])
    song.genre = genre
    song.artist = artist
    song
  end

  def self.create_from_filename(filename)
    files = Song.new_from_filename(filename)

  end
end
