module ServiceSpecsHelpers
  module TMSScraperHelpers
    def stub_tms_scraper_api_calls(course, *options)
      response = ScraperResponseDouble.build(course, *options)
      request_url = TMSScraperService::SCRAPER_URL + course.level.to_s
      allow(HTTParty).to receive(:get).with(request_url).and_return(response)
    end

    class ScraperResponseDouble
      include RSpec::Mocks::ExampleMethods

      def self.build(course, *options)
        new(course, *options).outer_response
      end

      attr_reader :outer_response

      def initialize(course, *options)
        @course = course
        @options = options
        @attrs = FactoryGirl.attributes_for :course,
                                            :with_prerequisite,
                                            :with_corequisite
        @parsed_response = {}
        build_response
      end

      def build_response
        build_response_code
        build_title
        build_description
        build_prerequisite
        build_corequisite
        build_inner_response
        build_outer_response
      end

      def build_response_code
        if @options.any? { |option| option == :bad_response_code }
          @response_code = "404"
        else
          @response_code = "200"
        end
      end

      def build_title
        return if @options.any? { |option| option == :nil_title_text }
        if @options.any? { |option| option == :blank_title_text }
          @parsed_response.merge!("title" => "")
        else
          @parsed_response.merge!("title" => @attrs[:title])
        end
      end

      def build_description
        return if @options.any? { |option| option == :nil_description_text }
        if @options.any? { |option| option == :blank_description_text }
          @parsed_response.merge!("courseDescription" => "")
        else
          @parsed_response.merge!("courseDescription" => @attrs[:description])
        end
      end

      def build_prerequisite
        return if @options.any? { |option| option == :nil_prerequisite_text }
        @parsed_response.merge!("prerequisite" => @attrs[:prerequisite])
      end

      def build_corequisite
        return if @options.any? { |option| option == :nil_corequisite_text }
        @parsed_response.merge!("corequisite" => @attrs[:corequisite])
      end

      def build_inner_response
        @inner_response = double(code: @response_code)
      end

      def build_outer_response
        @outer_response = double(parsed_response: @parsed_response,
                                 response: @inner_response)
      end
    end
  end
end
