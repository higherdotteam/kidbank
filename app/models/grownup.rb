class Grownup < Customer
  before_validation :make_pass

  def make_pass

    words = %W{Bat Bird Bunny Cat Chicken Crab Dog Ducks Elephant Fish Frog Giraffe Hedgehog Jellyfish Leopard 
     Monkey Moose Mouse Octopus Owl Panda Penguin Pig Rat Rabbit Reindeer Seahorse Sea Urchin
     Snake Sheep Starfish Tadpole Tiger Turkey Turtle Tortoise Zebra}

    a=words[rand(words.size)].downcase+(rand(9)+1).to_s
  end
end
