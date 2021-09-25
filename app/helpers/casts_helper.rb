module CastsHelper
  def markdownify(content)
    pipeline_context = {gfm: true}
    pipeline =
      HTML::Pipeline.new [
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::SanitizationFilter
      ],
        pipeline_context
    pipeline.call(content)[:output].to_s.html_safe
  end

  def short_markdownify(content)
    pipeline_context = {gfm: true}
    pipeline =
      HTML::Pipeline.new [
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::SanitizationFilter
      ],
        pipeline_context
    pipeline.call(content)[:output].to_s.truncate(
      120,
      escape: true, omission: "... (read more)"
    )
  end
end
