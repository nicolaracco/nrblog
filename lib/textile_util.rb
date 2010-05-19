require 'rubygems'
require 'coderay'
require 'RedCloth'

class TextileUtil
  def TextileUtil.to_html content
    content.force_encoding("UTF-8")
    RedCloth.new(code(content)).to_html
  end

  private
  def TextileUtil.code content
    last_index = 0
    while (found_index = content.index(/^\s*code(.*)\.\s?(.*)$/, last_index))
      mybody = content[found_index, content.length - found_index]

      c_fs = mybody.index('(')
      c_ls = mybody.index(')', c_fs)
      code_type = mybody[c_fs + 1, c_ls - c_fs - 1].to_sym if mybody.index(/^\s*code\(\w+\)\.\s?(.*)$/) == 0
      code_type ||= :plain

      start_body = mybody.index('.') + 1
      
      end_body = mybody.index(/^\s*$/, start_body)
      end_body ||= mybody.length
      mybody = mybody.gsub /^\s*\\\s*$/, ' '

      to_replace = do_coderay code_type, mybody[start_body, end_body - start_body].strip()
      content[found_index, end_body] = "\n" + to_replace + "\n"

      last_index = found_index + to_replace.length
    end

    return content
  end

  def TextileUtil.do_coderay type, block
    return '<notextile>' + CodeRay.scan(block, type).div(:line_numbers => :table) + '</notextile>'
  end
end
