module ImplantsHelper

    def tipo_carburante
        [
            ['Benzina', 'Benzina'],
            ['Blue Super', 'Blue Super'],
            ['Gasolio','Gasolio'],
            ['Blue Diesel','Blue Diesel'],
            ['Excellium Diesel','Excellium Diesel'],
            ['Metano','Metano'],
            ['GPL','GPL']
        ]
    end

    def ordine
        [
            ['Prezzo migliore', 'ASC'],
            ['Prezzo peggiore', 'DESC'],
            ['Prezzo Medio', 'MEDIA']
        ]
    end
end
