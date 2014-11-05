require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      template_name = template_name.to_s
      controller_name = self.class.to_s.underscore
      url = "views/#{controller_name}/#{template_name}.html.erb"
      erb_template = ERB.new(File.read(url))
      erb_template = erb_template.result(binding)
      self.render_content(erb_template, 'text/html')
    end
  end
end
