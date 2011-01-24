# CRZ - given a name to slug-ize, and either a list or a table and column, make a unique slug
#     - There's are inherent race conditions here, naturally.
#     - Should go like "b" -> "b_1"
# e.g. TheForce.unique_slug("My Gallery", Gallery, :permalink)
# e.g. TheForce.unique_slug("My Gallery", ["My_Gallery", "MY GALLERY"])
# e.g. before_validate 'self.permaslug = TheForce.unique_slug self.title, Article, :permaslug'
# e.g. before_validate 'self.permaslug = TheForce.unique_slug self.heading, Section.find_all_by_article_id(self.article.id).map {|s| s.heading}' 
module TheForce
  def self.unique_slug(title, *others)
    arr = others[0].find(:all).map { |e| e.send(others[1]) } if others.length == 2
    arr = others.first if others.length == 1

    base = title.strip.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
    slug, suffix = base, "1"
    while arr.include?(slug) do
      suffix.succ!
      slug = "#{base}_#{suffix}"
    end
    slug
  end
end