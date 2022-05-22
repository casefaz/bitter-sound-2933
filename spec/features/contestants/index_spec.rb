require 'rails_helper'

RSpec.describe 'contestant index page' do 
    describe 'user story 2' do
        it 'has n index page that lists each of the contestants with their projects' do 
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

            news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
            boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

            upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
            lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

            ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
            ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

            visit '/contestants'

            expect(page).to have_content(jay.name)
            expect(page).to have_content(gretchen.name)
            expect(page).to have_content(kentaro.name)
            expect(page).to have_content(erin.name)

            within "##{jay.id}" do 
                expect(page).to have_content(news_chic.name)
            end

            within "##{gretchen.id}" do 
                expect(page).to have_content(news_chic.name)
                expect(page).to have_content(upholstery_tux.name)
            end

            within "##{kentaro.id}" do 
                expect(page).to have_content(upholstery_tux.name)
                expect(page).to have_content(boardfit.name)
            end

            within "##{erin.id}" do 
                expect(page).to have_content(boardfit.name)
            end
        end
    end
end