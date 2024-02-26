require 'nokogiri';

module Jekyll
  class TableResponsive
    def self.process(document)
      # Early return if no tables are present.
      if document.output.index(/<table\b/).nil?
        return
      end

      wrapper = "<div class=\"table-responsive\"></div>"

      xpath_selector = '//body//table'
      xpath_selector << "[not(parent::div[contains(concat(' ', normalize-space(@class), ' '), ' table-responsive ')])]"
      # Exclude tables added to syntax highlighted code blocks.
      xpath_selector << '[not(ancestor::pre)][not(ancestor::code)]'

      parsed_document = Nokogiri::HTML(document.output)
      parsed_document.search(xpath_selector).each do |table_node|
        table_node.wrap(wrapper)
        table_node.add_class('table')
      end

      document.output = parsed_document.to_html
    end
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |document|
  Jekyll::TableResponsive.process(document) if document.write? and document.output_ext == '.html'
end
