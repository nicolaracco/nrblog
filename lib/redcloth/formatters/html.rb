require 'RedCloth'
require 'coderay'
require 'cgi'

module RedCloth::Formatters::HTML

  def bc_open(opts)
    classes = opts[:class].nil? ? [] : opts[:class].split(' ')
    if (classes.include? 'ish')
      return super
    else
      @isblock = true
      return ""
    end
  end

  def bc_close(opts)
    if !@isblock
      return super
    else
      @isblock = false
      return ""
    end
  end

  def code(opts)
    classes = opts[:class].nil? ? [] : opts[:class].split(' ')
    if (classes.include? 'ish')
      super
    else
      code_type = opts[:lang]
      if code_type.nil? && opts[:text].index(/\[\w+\]/) == 0 #Fix error for lang selector broken from 4.2.0
        cb_end = opts[:text].index(']')
        code_type = opts[:text][1, cb_end - 1]
        opts[:text] = opts[:text][cb_end + 1, s_code.length - cb_end - 1]
      end
      code_type ||= 'plain'
      if (code_type == 'none')
        super
      else
        s_code = CGI.unescapeHTML(opts[:text]).gsub /^\s*\\\s*$/, '' #Remove blank line markers
        scanned = CodeRay.scan(s_code, code_type.to_sym)
        lines_count = 0
        s_code.each_line { |line| lines_count += 1 }
        @isblock ? scanned.div(:line_numbers => lines_count > 1 ? :table : :inline, :css => :class) : scanned.span(:css => :class)
      end
    end
  end
end
