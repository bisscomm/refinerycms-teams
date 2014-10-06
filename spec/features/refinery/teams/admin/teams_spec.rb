# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Teams" do
    describe "Admin" do
      describe "teams" do
        refinery_login_with :refinery_user

        describe "teams list" do
          before do
            FactoryGirl.create(:team, :fullname => "UniqueTitleOne")
            FactoryGirl.create(:team, :fullname => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.teams_admin_teams_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.teams_admin_teams_path

            click_link "Add New Team"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Fullname", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Teams::Team.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Fullname can't be blank")
              Refinery::Teams::Team.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:team, :fullname => "UniqueTitle") }

            it "should fail" do
              visit refinery.teams_admin_teams_path

              click_link "Add New Team"

              fill_in "Fullname", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Teams::Team.count.should == 1
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

            page.should have_content("'A different fullname' was successfully updated.")
            page.should have_no_content("A fullname")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:team, :fullname => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.teams_admin_teams_path

            click_link "Remove this team forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Teams::Team.count.should == 0
          end
        end

      end
    end
  end
end
