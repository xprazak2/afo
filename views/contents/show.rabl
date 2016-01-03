object @content
attributes :id, :title, :content

node(:kram_content) { |c| ::Kramdown::Document.new(c.content).to_html }