require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let!(:team) { create(:team) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @teams" do
      get :index
      expect(assigns(:teams)).to eq([team])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: team.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @team" do
      get :show, params: { id: team.id }
      expect(assigns(:team)).to eq(team)
    end

    it "renders the show template" do
      get :show, params: { id: team.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns a new team" do
      get :new
      expect(assigns(:team)).to be_a_new(Team)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new team" do
        expect {
          post :create, params: { team: attributes_for(:team) }
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
        post :create, params: { team: attributes_for(:team) }
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it "redirects to the created team" do
        post :create, params: { team: attributes_for(:team) }
        expect(response).to redirect_to(Team.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        post :create, params: { team: { name: nil } }
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the new template" do
        post :create, params: { team: { name: nil } }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: team.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @team" do
      get :edit, params: { id: team.id }
      expect(assigns(:team)).to eq(team)
    end

    it "renders the edit template" do
      get :edit, params: { id: team.id }
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    let!(:team) { FactoryBot.create(:team) } # using FactoryBot to create a test team

    context "with valid params" do
      let(:new_name) { "Updated Team Name" }

      it "updates the team" do
        patch :update, params: { id: team.id, team: { name: new_name } }

        team.reload # need to reload the team to see the changes made in the database

        expect(team.name).to eq new_name
      end

      it "redirects to the team show page" do
        patch :update, params: { id: team.id, team: { name: new_name } }

        expect(response).to redirect_to(team_path(team))
      end
    end

    context "with invalid params" do
      let(:invalid_name) { "" }

      it "does not update the team" do
        patch :update, params: { id: team.id, team: { name: invalid_name } }
        team.reload

        expect(team.name).not_to eq invalid_name
      end

      it "re-renders the edit page" do
        patch :update, params: { id: team.id, team: { name: invalid_name } }

        expect(response).to render_template(:edit)
      end
    end
  end
end
