## Cucumber

**Feature: Station comment**
  As a user
  So that I can give an opinion about a station
  I want to add a comment

**Feature: Add station**
  As an admin user
  So that I can give more info about a station
  I want to create a new station

**Feature: Edit profile**
  As a registered user
  So that I can change the info about me
  I want to edit my profile

**Feature: User can login to the system**
  As a registered user
  So that I can interact with the system
  I want to log in the system

**Feature: Search stations**
  As a user
  So that I can find the cheapest gas stations nearby
  I want to insert my location

**Feature: User can create a new account**
  As a visitor
  So that the system remembers me
  I want to create a new account



## RSpec

it "Validazione utente"

it "Creazione utente"

it "Utente senza email"

it "Utente senza password"

describe "Creazione Stazione senza Bandiera" do
        it "dovrebbe non essere valida"

describe "Creazione Inserzione senza indirizzo" do
        it "dovrebbe non essere valida" 

describe "Creazione Inserzione mettendo una stringa come prezzo" do
        it "dovrebbe non essere valida"

describe "Creazione Inserzione con prezzo negativo" do
        it "dovrebbe non essere valida"

describe "Creazione Inserzione completa" do
        it "dovrebbe essere valida e salvata correttamente"

context "Inserzione con 2 o più recensioni" do
        it "dovrei vedere le recensioni ordinate per data crescente"