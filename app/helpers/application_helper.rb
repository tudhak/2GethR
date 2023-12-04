module ApplicationHelper
  def bg_image(controller_name, action_name)
    bg_name = if controller_name == "pages" && action_name == "home"
      asset_path('backgrounds/landing_bg.svg')
    end
  end
end
