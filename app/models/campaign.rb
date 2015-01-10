class Campaign < ActiveRecord::Base
  belongs_to :collaboration
  has_many :posts

  def color
    colors = [
      "#ac725e",
      "#d06b64",
      "#f83a22",
      "#fa573c",
      "#ff7537",
      "#ffad46",
      "#42d692",
      "#16a765",
      "#7bd148",
      "#b3dc6c",
      "#fbe983",
      "#fad165",
      "#92e1c0",
      "#9fe1e7",
      "#9fc6e7",
      "#4986e7",
      "#9a9cff",
      "#b99aff",
      "#c2c2c2",
      "#cabdbf",
      "#cca6ac",
      "#f691b2",
      "#cd74e6",
      "#a47ae2"
    ]
    colors[self.id % colors.size]
  end
end
