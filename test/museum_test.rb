require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_it_has_exhibits
    assert_equal [], @dmns.exhibits

    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits

    assert_equal [], @dmns.recommend_exhibits(@bob)
    assert_equal [], @dmns.recommend_exhibits(@sally)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")

    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @dmns.recommend_exhibits(@bob)
    assert_equal ["IMAX"], @dmns.recommend_exhibits(@sally)
  end

  def test_it_can_have_patrons
    assert_equal [], @dmns.patrons

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_list_patrons_by_exhibit_interest
    patron_testing_exhibit = {}
    assert_equal patron_testing_exhibit, @dmns.patrons_by_exhibit_interest

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")
    @sally.add_interest("Dead Sea Scrolls")

    patron_testing_exhibit2 = {
                  "Gems and Minerals" => ["Bob"],
                  "Dead Sea Scrolls" => ["Sally", "Bob"],
                  "IMAX" => ["Sally"]
                              }
    assert_equal patron_testing_exhibit2, @dmns.patrons_by_exhibit_interest
  end
end
