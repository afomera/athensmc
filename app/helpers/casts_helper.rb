require "html_pipeline/convert_filter/markdown_filter"

module CastsHelper
  def markdownify(content)
    pipeline = HTMLPipeline.new(
      convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new
    )
    pipeline.call(content)[:output].html_safe
  end

  def short_markdownify(content)
    pipeline = HTMLPipeline.new(
      convert_filter: HTMLPipeline::ConvertFilter::MarkdownFilter.new
    )
    pipeline.call(content)[:output].truncate(
      120,
      escape: true, omission: "... (read more)"
    )
  end
end
