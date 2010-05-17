# coding: utf-8

require 'rubygems'
require 'coderay'
require 'RedCloth'

class TextileUtil
  def TextileUtil.to_html content
    RedCloth.new(highlight content).to_html
  end

  private
  def TextileUtil.highlight content
    content.gsub /\[code:(.*)\](.*)\[\/code\]/m do |code|
      codestart = code.index(']') + 1
      codeend = code.rindex '[/code]'
      codetype = code[6, codestart - 7]
      code.replace '<notextile>' + CodeRay.scan(code[codestart, codeend - codestart].chomp, codetype.to_sym).div(:line_numbers => :table) + '</notextile>'
    end
  end
end
