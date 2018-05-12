module ImplantsHelper

    #header della pagina dei risultati
    def calcola_numero_impianti_trovati(implant)
        titolo = ""
        num = @implant.count('Implants.idImpianto').length
        if num == 0
            titolo = "Nessun impianto trovato."
        elsif num == 1
            titolo = "1 impianto trovato"
        else
            titolo = "#{num} impianti trovati"
        end
        return titolo
    end

    #ottiene il logo della stazione di rifornimento cercata
    def get_implant_logo(query)
        res = HTTParty.get(
            "https://api.qwant.com/api/search/images?q=#{query}%20logo",
            :query => {:output => 'json'}
        )
        return res["data"]["result"]["items"][0]["media"]
    end

    #converte timestamp unix in orario normale
    def unixToHuman (timestamp)
        #https://stackoverflow.com/a/3964560/1440037
        return Time.at(timestamp).utc.in_time_zone(+2).strftime("%H:%M:%S")
    end

    def tipo_carburante
        [
            ['Benzina', 'Benzina'],
            ['Blue Super', 'Blue Super'],
            ['Gasolio', 'Gasolio'],
            ['Blue Diesel', 'Blue Diesel'],
            ['Excellium Diesel', 'Excellium Diesel'],
            ['Metano', 'Metano'],
            ['GPL', 'GPL']
        ]
    end

    def get_list_stazioni
        Implant
            .select('Bandiera')
            .from('implants')
            .group('Bandiera')
            .order('Bandiera ASC')
            .pluck("Bandiera") #converte in array
    end

    def ordine
        [
            ['Prezzo migliore', 'ASC'],
            ['Prezzo peggiore', 'DESC'],
            ['Prezzo medio', 'MEDIA'],
            ['Andamento', 'ANDAMENTO']
        ]
    end

    def province
        [
            ['Agrigento', 'AG'],
            ['Alessandria', 'AL'],
            ['Ancona', 'AN'],
            ['Aosta', 'AO'],
            ['Arezzo', 'AR'],
            ['Ascoli Piceno', 'AP'],
            ['Asti', 'AT'],
            ['Avellino', 'AV'],
            ['Bari', 'BA'],
            ['Barletta-Andria-Trani', 'BT'],
            ['Belluno', 'BL'],
            ['Benevento', 'BN'],
            ['Bergamo', 'BG'],
            ['Biella', 'BI'],
            ['Bologna', 'BO'],
            ['Bolzano', 'BZ'],
            ['Brescia', 'BS'],
            ['Brindisi', 'BR'],
            ['Cagliari', 'CA'],
            ['Caltanissetta', 'CL'],
            ['Campobasso', 'CB'],
            ['Carbonia-Iglesias', 'CI'],
            ['Caserta', 'CE'],
            ['Catania', 'CT'],
            ['Catanzaro', 'CZ'],
            ['Chieti', 'CH'],
            ['Como', 'CO'],
            ['Cosenza', 'CS'],
            ['Cremona', 'CR'],
            ['Crotone', 'KR'],
            ['Cuneo', 'CN'],
            ['Enna', 'EN'],
            ['Fermo', 'FM'],
            ['Ferrara', 'FE'],
            ['Firenze', 'FI'],
            ['Foggia', 'FG'],
            ['Forlì-Cesena', 'FC'],
            ['Frosinone', 'FR'],
            ['Genova', 'GE'],
            ['Gorizia', 'GO'],
            ['Grosseto', 'GR'],
            ['Imperia', 'IM'],
            ['Isernia', 'IS'],
            ['La Spezia', 'SP'],
            ['L\'Aquila', 'AQ'],
            ['Latina', 'LT'],
            ['Lecce', 'LE'],
            ['Lecco', 'LC'],
            ['Livorno', 'LI'],
            ['Lodi', 'LO'],
            ['Lucca', 'LU'],
            ['Macerata', 'MC'],
            ['Mantova', 'MN'],
            ['Massa-Carrara', 'MS'],
            ['Matera', 'MT'],
            ['Messina', 'ME'],
            ['Milano', 'MI'],
            ['Modena', 'MO'],
            ['Monza e della Brianza', 'MB'],
            ['Napoli', 'NA'],
            ['Novara', 'NO'],
            ['Nuoro', 'NU'],
            ['Olbia-Tempio', 'OT'],
            ['Oristano', 'OR'],
            ['Padova', 'PD'],
            ['Palermo', 'PA'],
            ['Parma', 'PR'],
            ['Pavia', 'PV'],
            ['Perugia', 'PG'],
            ['Pesaro e Urbino', 'PU'],
            ['Pescara', 'PE'],
            ['Piacenza', 'PC'],
            ['Pisa', 'PI'],
            ['Pistoia', 'PT'],
            ['Pordenone', 'PN'],
            ['Potenza', 'PZ'],
            ['Prato', 'PO'],
            ['Ragusa', 'RG'],
            ['Ravenna', 'RA'],
            ['Reggio Calabria', 'RC'],
            ['Reggio Emilia', 'RE'],
            ['Rieti', 'RI'],
            ['Rimini', 'RN'],
            ['Roma', 'RM'],
            ['Rovigo', 'RO'],
            ['Salerno', 'SA'],
            ['Medio Campidano', 'VS'],
            ['Sassari', 'SS'],
            ['Savona', 'SV'],
            ['Siena', 'SI'],
            ['Siracusa', 'SR'],
            ['Sondrio', 'SO'],
            ['Taranto', 'TA'],
            ['Teramo', 'TE'],
            ['Terni', 'TR'],
            ['Torino', 'TO'],
            ['Ogliastra', 'OG'],
            ['Trapani', 'TP'],
            ['Trento', 'TN'],
            ['Treviso', 'TV'],
            ['Trieste', 'TS'],
            ['Udine', 'UD'],
            ['Varese', 'VA'],
            ['Venezia', 'VE'],
            ['Verbano-Cusio-Ossola', 'VB'],
            ['Vercelli', 'VC'],
            ['Verona', 'VR'],
            ['Vibo Valentia', 'VV'],
            ['Vicenza', 'VI'],
            ['Viterbo', 'VT']
        ]
    end

    def province_reverse
        {
            'AG' => 'Agrigento',
            'AL' => 'Alessandria',
            'AN' => 'Ancona',
            'AO' => 'Aosta',
            'AR' => 'Arezzo',
            'AP' => 'Ascoli Piceno',
            'AT' => 'Asti',
            'AV' => 'Avellino',
            'BA' => 'Bari',
            'BT' => 'Barletta-Andria-Trani',
            'BL' => 'Belluno',
            'BN' => 'Benevento',
            'BG' => 'Bergamo',
            'BI' => 'Biella',
            'BO' => 'Bologna',
            'BZ' => 'Bolzano',
            'BS' => 'Brescia',
            'BR' => 'Brindisi',
            'CA' => 'Cagliari',
            'CL' => 'Caltanissetta',
            'CB' => 'Campobasso',
            'CI' => 'Carbonia-Iglesias',
            'CE' => 'Caserta',
            'CT' => 'Catania',
            'CZ' => 'Catanzaro',
            'CH' => 'Chieti',
            'CO' => 'Como',
            'CS' => 'Cosenza',
            'CR' => 'Cremona',
            'KR' => 'Crotone',
            'CN' => 'Cuneo',
            'EN' => 'Enna',
            'FM' => 'Fermo',
            'FE' => 'Ferrara',
            'FI' => 'Firenze',
            'FG' => 'Foggia',
            'FC' => 'Forlì-Cesena',
            'FR' => 'Frosinone',
            'GE' => 'Genova',
            'GO' => 'Gorizia',
            'GR' => 'Grosseto',
            'IM' => 'Imperia',
            'IS' => 'Isernia',
            'SP' => 'La Spezia',
            'AQ' => 'L\'Aquila',
            'LT' => 'Latina',
            'LE' => 'Lecce',
            'LC' => 'Lecco',
            'LI' => 'Livorno',
            'LO' => 'Lodi',
            'LU' => 'Lucca',
            'MC' => 'Macerata',
            'MN' => 'Mantova',
            'MS' => 'Massa-Carrara',
            'MT' => 'Matera',
            'ME' => 'Messina',
            'MI' => 'Milano',
            'MO' => 'Modena',
            'MB' => 'Monza e della Brianza',
            'NA' => 'Napoli',
            'NO' => 'Novara',
            'NU' => 'Nuoro',
            'OT' => 'Olbia-Tempio',
            'OR' => 'Oristano',
            'PD' => 'Padova',
            'PA' => 'Palermo',
            'PR' => 'Parma',
            'PV' => 'Pavia',
            'PG' => 'Perugia',
            'PU' => 'Pesaro e Urbino',
            'PE' => 'Pescara',
            'PC' => 'Piacenza',
            'PI' => 'Pisa',
            'PT' => 'Pistoia',
            'PN' => 'Pordenone',
            'PZ' => 'Potenza',
            'PO' => 'Prato',
            'RG' => 'Ragusa',
            'RA' => 'Ravenna',
            'RC' => 'Reggio Calabria',
            'RE' => 'Reggio Emilia',
            'RI' => 'Rieti',
            'RN' => 'Rimini',
            'RM' => 'Roma',
            'RO' => 'Rovigo',
            'SA' => 'Salerno',
            'VS' => 'Medio Campidano',
            'SS' => 'Sassari',
            'SV' => 'Savona',
            'SI' => 'Siena',
            'SR' => 'Siracusa',
            'SO' => 'Sondrio',
            'TA' => 'Taranto',
            'TE' => 'Teramo',
            'TR' => 'Terni',
            'TO' => 'Torino',
            'OG' => 'Ogliastra',
            'TP' => 'Trapani',
            'TN' => 'Trento',
            'TV' => 'Treviso',
            'TS' => 'Trieste',
            'UD' => 'Udine',
            'VA' => 'Varese',
            'VE' => 'Venezia',
            'VB' => 'Verbano-Cusio-Ossola',
            'VC' => 'Vercelli',
            'VR' => 'Verona',
            'VV' => 'Vibo Valentia',
            'VI' => 'Vicenza',
            'VT' => 'Viterbo'
        }
    end

    def regioni
        [
            ["Piemonte"],
            ["Valle d'Aosta"],
            ["Lombardia"],
            ["Trentino-Alto Adige"],
            ["Veneto"],
            ["Friuli-Venezia Giulia"],
            ["Liguria"],
            ["Emilia-Romagna"],
            ["Toscana"],
            [" Umbria"],
            [" Marche"],
            [" Lazio"],
            [" Abruzzo"],
            [" Molise"],
            [" Campania"],
            [" Puglia"],
            [" Basilicata"],
            [" Calabria"],
            [" Sicilia"],
            [" Sardegna"]
        ]
    end

    def regioni_reverse
        {
            "Piemonte" => "Piemonte",
            "Valle d'Aosta" => "Valle d'Aosta",
            "Lombardia" => "Lombardia",
            "Trentino-Alto Adige" => "Trentino-Alto Adige",
            "Veneto" => "Veneto",
            "Friuli-Venezia Giulia" => "Friuli-Venezia Giulia",
            "Liguria" => "Liguria",
            "Emilia-Romagna" => "Emilia-Romagna",
            "Toscana" => "Toscana",
            " Umbria" => "Umbria",
            " Marche" => "Marche",
            " Lazio" => "Lazio",
            " Abruzzo" => "Abruzzo",
            " Molise" => "Molise",
            " Campania" => "Campania",
            " Puglia" => "Puglia",
            " Basilicata" => "Basilicata",
            " Calabria" => "Calabria",
            " Sicilia" => "Sicilia",
            " Sardegna" => "Sardegna"
        }
    end

end
