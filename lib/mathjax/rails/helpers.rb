module Mathjax
  module Rails
    module ViewHelpers
      def mathjax_tag(opt={})
        if false==opt[:config]
          additional = ''
        else
          opt[:config] = 'TeX-AMS-MML_HTMLorMML.js' if !opt[:config]
          additional = "?config=#{opt[:config]}"
        end
      	"<script type=\"text/javascript\">head.js(\"#{mathjax_path(:uri=>'MathJax.js')}#{additional}\" );</script>".html_safe
      end
    end
  end
end
ActionView::Base.send :include, Mathjax::Rails::ViewHelpers