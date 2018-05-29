require 'rails_helper'

RSpec.describe Station, type: :model do

    describe "Creazione Stazione senza Bandiera" do
        it "dovrebbe non essere valida" do
            station = Station.new(
                :Nome => "Mario ROssi",
                :Indirizzo => "Via Ariosto 22, Roma",
                :Benzina => "1.578", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )
            expect(station).not_to be_valid
        end
    end

    describe "Creazione Inserzione senza indirizzo" do
        it "dovrebbe non essere valida" do
            station = Station.new(
                :Bandiera => "ESSO",
                :Nome => "Mario ROssi",
                :Benzina => "1.578", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )
            expect(station).not_to be_valid
        end
    end

       describe "Creazione Inserzione mettendo una stringa come prezzo" do
        it "dovrebbe non essere valida" do
            station = Station.new(
                :Bandiera => "ESSO",
                :Nome => "Mario ROssi",
                :Benzina => "stringa", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )
            expect(station).not_to be_valid
        end
    end

    describe "Creazione Inserzione con prezzo negativo" do
        it "dovrebbe non essere valida" do
            station = Station.new(
                :Bandiera => "ESSO",
                :Nome => "Mario ROssi",
                :Benzina => "-0.789", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )
            expect(station).not_to be_valid
        end
    end

    describe "Creazione Inserzione completa" do
        it "dovrebbe essere valida e salvata correttamente" do
            station = Station.new(
                :Bandiera => "ESSO",
                :Nome => "Mario ROssi",
                :Indirizzo => "Via Ariosto 22, Roma",
                :Benzina => "1.578", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )
            expect(station).to be_valid
            station.save
            expect(Station.first).to eq(station)
        end
    end

    context "Inserzione con 2 o più recensioni" do
        it "dovrei vedere le recensioni ordinate per data crescente" do
            station = Station.new(
                :Bandiera => "ESSO",
                :Nome => "Mario ROssi",
                :Indirizzo => "Via Ariosto 22, Roma",
                :Benzina => "1.578", :Diesel => "1.389", :Super => "", :Excellium => "", :Metano => "0.579", :GPL => "",
                :allDay => "", :Self => "", :autoLavaggio => ""
            )            
            station.save!
            recensione1 = station.comments.create!(:title => "Prima Recensione", :body => "Questa è la prima recensione")
            recensione2 = station.comments.create!(:title => "Seconda Recensione", :body => "Questa è la seconda recensione")
            expect(station.reload.comments).to eq([recensione1, recensione2])
        end
    end

end
