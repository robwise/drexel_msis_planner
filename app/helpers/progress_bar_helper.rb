module ProgressBarHelper
  def build_progress_bar(numerator, denominator)
    display_value = "#{ numerator }/#{ denominator }"
    value_now = (numerator.to_f / denominator * 100).to_i
    width = "#{value_now}%"
    options = { class: "progress-bar",
                role: "progressbar",
                "aria-valuenow" => value_now,
                "aria-valuemin" => "0",
                "aria-valuemax" => "100",
                style: "min-width: 2em; width: #{ width }" }
    content_tag(:div, content_tag(:div, display_value, options), class: "progress")
  end
end
