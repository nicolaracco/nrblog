require 'RedCloth'
require 'coderay'
require 'cgi'

module RedCloth::Formatters::HTML

  def bc_open(opts)
    if (opts[:lang] == 'none')
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
    code_type = opts[:lang]
    if code_type.nil? && opts[:text].index(/\[\w+\]/) == 0 #Fix error for lang selector broken from 4.2.0
      cb_end = opts[:text].index(']')
      code_type = opts[:text][1, cb_end - 1]
      opts[:text] = opts[:text][cb_end + 1, opts[:text].length - cb_end - 1]
    end
    code_type ||= 'plain'
    if (code_type == 'none')
      super
    else
      s_code = CGI.unescapeHTML(opts[:text]).gsub /^\s*\\\s*$/, '' #Remove blank line markers
      scanned = CodeRay.scan(s_code, code_type.to_sym)
      classes = opts[:class] ? opts[:class].split(' ') : []
      if classes.include? 'ln'
        lines_count = 0
        s_code.each_line { |line| lines_count += 1 }
        show_lines = lines_count > 1

        if show_lines
          highlighted = []
          classes.each do |cl|
            cl.sub(/\Ah(\d+)_(\d+)\z/) { |block| (Integer($1)..Integer($2)).each { |index| highlighted << index } }
            cl.sub(/\Ah(\d+)\z/) { |block| highlighted << $1.to_i }
          end
          puts ">>>> #{highlighted}"
          highlighted = nil if highlighted.empty? # else will disable bolding
        end
      end
      @isblock ? scanned.div(:line_numbers => show_lines ? :table : nil, :css => :class, :highlight_lines => highlighted) : scanned.span(:css => :class)
    end
  end
end
