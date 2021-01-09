class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :tag_ids, array: :integer

  def search
    relation = User.distinct
    relation = relation.by_name(name) if name.present?
    relation = relation.by_tag(tag_ids) if tag_ids.present?
    relation
  end
end
