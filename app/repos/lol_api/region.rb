module LolApi
  class Region
    REGIONS  = [
      'br',
      'eune',
      'euw',
      'kr',
      'lan',
      'na',
      'ru',
      'tr',
    ]

    def all
      REGIONS
    end

    def options_for_select
      all.map do |region|
        [I18n.t("region.#{region}"), region]
      end
    end

  end
end
