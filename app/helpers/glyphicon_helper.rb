module GlyphiconHelper
  def collapse_button(args = {})
    glyphicon_span = build_glyphicon_span(args)
    sr_content_span = build_sr_content_span
    classes = build_classes
    href = build_href
    aria_controls = href.slice(1..(href.size + 1))
    options = build_options(classes, href, aria_controls)

    content_tag(:a, glyphicon_span + "/n" + sr_content_span, options, false)
  end

  # Simplifies using Bootstrap Glyphicons. To use 'glyphicon-plus', simply pass
  # an argument of 'plus' or :plus
  def glyphicon(name)
    empty_span = content_tag(:span)
    content_tag(:div, empty_span, class: "glyphicon glyphicon-#{name.to_s}")
  end

  private

  def build_glyphicon_span(args)
    glyphicon_classes = "glyphicon "
    if args[:glyphicon].nil?
      glyphicon_classes << "glyphicon-collapse-down"
    else
      glyphicon_classes << args[:glyphicon]
    end
    content_tag(:span, { class: glyphicon_classes }, false)
  end

  def build_sr_content_span(args)
    sr_text = build_sr_text(args)
    content_tag(:span, sr_text, { class: "sr-only" }, false)
  end

  def build_sr_text(args)
    args[:sr_text].nil? ? "click to collapse" : args[:sr_text]
  end

  def build_classes(args)
    classes = args[:classes].nil? ? "" : args[:classes]
    classes ||= ""
    classes << " toggle-section"
    classes.strip
  end

  def build_href(args)
    args[:href].nil? ? "#" : args[:href]
  end

  def build_options(classes, href, aria_controls)
    { class: classes,
      "data-toggle" => "collapse",
      href: href,
      "aria-expanded" => "false",
      "aria-controls" => aria_controls }
  end
end
