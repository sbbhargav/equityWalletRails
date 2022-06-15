module ApplicationHelper

	def back_link(path)
		link_to 'back', path, class: 'btn btn-primary'
	end
	def delete_link(path,style_class)
		button_to 'delete', path, method: :delete, class: style_class
	end

	def show_link(path,style_class)
		link_to 'show', path, class: style_class
	end

	def edit_link(path,style_class)
		link_to 'edit', path, class: style_class
	end

end
