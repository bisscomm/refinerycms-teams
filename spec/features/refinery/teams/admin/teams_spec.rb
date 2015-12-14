# encoding: utf-8
require "spec_helper"

module Refinery
  module Teams
    module Admin
      describe "teams", type: :feature do
        refinery_login

        describe "teams list" do
          before do
            FactoryGirl.create(:team, :fullname => "UniqueTitleOne")
            FactoryGirl.create(:team, :fullname => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.teams_admin_teams_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.teams_admin_teams_path

            click_link "Add new team member"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Fullname", :with => "This is a test of the first string field"
              click_button "Save"

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
              expect(Refinery::Teams::Team.count).to eq 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              expect(page).to have_content("Fullname can't be blank")
              expect(Refinery::Teams::Team.count).to eq 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:team, :fullname => "UniqueTitle") }

            it "should fail" do
              visit refinery.teams_admin_teams_path

              click_link "Add new team member"

              fill_in "Fullname", :with => "UniqueTitle"
              click_button "Save"

              expect(page).to have_content("There were problems")
              expect(Refinery::Teams::Team.count).to eq 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:team, :fullname => "A fullname") }

          it "should succeed" do
            visit refinery.teams_admin_teams_path

            within ".actions" do
              click_link "Edit this team"
            end

            fill_in "Fullname", :with => "A different fullname"
            click_button "Save"

            expect(page).to have_content("'A different fullname' was successfully updated.")
            expect(page).to have_no_content("A fullname")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:team, :fullname => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.teams_admin_teams_path

            click_link "Delete this team member"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Teams::Team.count).to eq 0
          end
        end

      end
    end
  end
end
