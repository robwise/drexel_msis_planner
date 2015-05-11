module ApplicationHelper
  def collapse_button(args = {})
    glyphicon_classes = "glyphicon "
    glyphicon_classes << (args[:glyphicon].nil? ? "glyphicon-collapse-down" : args[:glyphicon])
    glyphicon_span = content_tag(:span, { class: glyphicon_classes }, false)
    sr_text = args[:sr_text].nil? ? "click to collapse" : args[:sr_text]
    sr_content_span = content_tag(:span,
                                  sr_text,
                                  { class: "sr-only" },
                                  false)

    classes = args[:classes].nil? ? "" : args[:classes]
    classes ||= ""
    classes << " toggle-section"
    classes.strip!

    href = args[:href].nil? ? "#" : args[:href]
    aria_controls = href.slice(1..(href.size + 1))

    options = { class: classes,
                "data-toggle" => "collapse",
                href: href,
                "aria-expanded" => "false",
                "aria-controls" => aria_controls }
    content_tag(:a, glyphicon_span + "/n" + sr_content_span, options, false)
  end
end
