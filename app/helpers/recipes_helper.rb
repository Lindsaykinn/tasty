module RecipesHelper

  def display_index_header
    if @category
      content_tag(:h3, "Create Recipe for #{@category.name}")
    else
      content_tag(:h3, "All Recipes")
    end
  end

  def display_new_header
    if @category
      content_tag(:h3, "Create a Recipe for #{@category.name}")
    else
      content_tag(:h3, "Create a Recipe")
    end
  end

  def category_form_fields(f)
    if @category 
      f.hidden_field :category_id, value: @category.id
    else
      render partial: "category_fields", locals: { f: f}
    end
  end
end
