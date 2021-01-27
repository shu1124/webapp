class SearchMicropostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :genre_ids, array: :integer

  def search
    relation = Micropost.distinct
    relation = relation.by_title(title) if title.present?
    relation = relation.by_genre(genre_ids) if genre_ids.present?
    relation
  end
end
