extends "contents/show"

if @content.errors.any?
  node :errors do
    @content.errors.keys.map { |k| { k.to_s => @content.errors[k] } }
  end
end