class Museum

attr_reader :name, :exhibits, :recommend_exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @recommend_exhibits_to_patrons = []
    @patrons = []
    @exhibits_by_interest = {}
  end

  def add_exhibit(exhibit_name)
    @exhibits << exhibit_name
  end


  def rec_to_patron(patron)
    patron.interests.each do |interest|
      @recommend_exhibits_to_patrons << interest
    end
  end

  def recommend_exhibits(patron)
    rec_to_patron(patron)
  end

  def admit(patron)
    @patrons << patron
  end

  def

  end
  end

  def patrons_by_exhibit_interest
    #hash with key of exhibits and value of array of patrons
    require 'pry'; binding.pry
    recommend_exhibits(patron).group_by do |exhibit|
      @exhibits_by_interest.merge[:exhibit] = @patron
    end
  end
end
