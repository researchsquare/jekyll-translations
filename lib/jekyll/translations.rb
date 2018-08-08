require "jekyll/translations/version"

module Jekyll
    require 'json'
    require 'open-uri'

    module Translations
        class Generator < Jekyll::Generator
            def generate(site)
                translation_source = site.config['translations']['source']

                site.data['translations'] = JSON.parse(open(translation_source).read)
            end
        end

        module TranslateFilter
            @translations = []
            @localizationContext = nil
            @skipTranslationCheck = nil
            @debug_translations = false

            def translations
                return @translations if @translations

                site = @context.registers[:site]
                config = site.config['translations']
                @skipTranslationCheck = config['skipTranslationCheck']
                @debug_translations = !@skipTranslationCheck and ENV['DEBUG_TRANSLATIONS'].to_i === 1

                translation_data = site.data['translations']
                translations = translation_data['common']

                if config['context'] and translation_data[config['context']]
                    translations = translations.merge(translation_data[config['context']])
                end

                return translations
            end

            def translate_array(array)
                translated_hash = Hash.new
                array.each { |item| translated_hash[item] = self.t(item) }

                return translated_hash
            end

            def t(text, args = [])
                # If we've an array, translate each item and return
                return self.translate_array(text) if text.kind_of?(Array)

                @translations = self.translations

                # Uncomment the following block to see a list of items missing translations
                # if @translations[text].nil?
                #   puts text.to_json + "\n"
                # end

                # Fail tests in CircleCI if we don't have translations
                if ENV['CIRCLECI'] and text and @translations[text].nil?
                    unless @context.environments.first['page']['skip_translation_check'] or @skipTranslationCheck
                        raise Exception.new("Translation not found for: #{text}")
                    end
                end

                if text and @translations[text].nil?
                    return @debug_translations ? "<span style='color:red !important;'>#{text}</span>" : text
                end

                # Cast our stuff to strings to ensure the % operator works as expected below
                if args.kind_of?(Array)
                    args = args.map { |arg| arg.to_s }
                else
                    args = args.to_s
                end

                return (@translations[text] % args) if not args.empty?
                return @translations[text]
            end
        end
    end
end

Liquid::Template.register_filter(Translations::TranslateFilter)
