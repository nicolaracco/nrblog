require 'rubygems'
require 'coderay'

class Highlighter
  def Highlighter.highlight content
    content.gsub /\[code:(.*)\](.*)\[\/code\]/m do |code|
      codestart = code.index(']') + 1
      codeend = code.rindex '[/code]'
      codetype = code[6, codestart - 7]
      code.replace '<notextile>' + CodeRay.scan(code[codestart, codeend - codestart].chomp, codetype.to_sym).div(:line_numbers => :table) + '</notextile>'
    end
  end
end
