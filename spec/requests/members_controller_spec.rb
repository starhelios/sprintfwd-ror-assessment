require 'rails_helper'

RSpec.describe MembersController, type: :request do
  let(:team) { create(:team) }
  let(:member) { create(:member, team: team) }
  let(:project) { create(:project) }

  describe 'GET #index' do
    it 'returns http success' do
      get members_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get member_path(member)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get new_member_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get edit_member_path(member)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        { member: { first_name: 'John', last_name: 'Doe', team_id: team.id } }
      end

      it 'creates a new member' do
        expect do
          post members_path, params: valid_params
        end.to change(Member, :count).by(1)
      end

      it 'redirects to the created member' do
        post members_path, params: valid_params
        expect(response).to redirect_to(Member.last)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { member: { first_name: '', last_name: '' } }
      end

      it 'does not create a new member' do
        expect do
          post members_path, params: invalid_params
        end.to_not change(Member, :count)
      end

      it 'renders the new template' do
        post members_path, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_params) do
        { member: { first_name: 'Jane' } }
      end

      it 'updates the member' do
        patch member_path(member), params: valid_params
        expect(member.reload.first_name).to eq('Jane')
      end

      it 'redirects to the member' do
        patch member_path(member), params: valid_params
        expect(response).to redirect_to(member)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { member: { first_name: '' } }
      end

      it 'does not update the member' do
        expect do
          patch member_path(member), params: invalid_params
        end.to_not change { member.reload.first_name }
      end

      it 'renders the edit template' do
        patch member_path(member), params: invalid_params
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the member' do
      member
      expect do
        delete member_path(member)
      end.to change(Member, :count).by(-1)
    end
  end
end
