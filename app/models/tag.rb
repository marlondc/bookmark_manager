
class Tag
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :name, String


  def split_tags
    name.split(",").strip
  end

end
