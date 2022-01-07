require 'rails_helper'

RSpec.describe "Api::VDesktop::Subjects", type: :request do
  describe '/GET #index' do
    #let(:disciplina1) { create(:subject) }
    #let(:disciplina2) { create(:subject) }

    before do
      create(:subject, name: 'disciplina 1')
      create(:subject, name: 'disciplina 2')
      get '/api/v_desktop/subjects/index'
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a json' do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it 'returns 2 elements' do
      expect(JSON.parse(response.body).size).to eq(2)
    end  
  end

  describe '/GET #show' do
    let(:disciplina) { create(:subject) }

    context 'when subject exists' do
      before { get "/api/v_desktop/subjects/show/#{disciplina.id}" }

      it { expect(response).to have_http_status(200) }

      it "returns a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context 'when subject does not exist' do
      before do
        disciplina.destroy
        get "/api/v_desktop/subjects/show/#{disciplina.id}"
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'does not return a json' do
        #expect(response.content_type).to eq("text/html")
        expect(response.content_type).not_to eq("application/json; charset=utf-8")
      end
    end
  end

  describe '/POST #CREATE' do
    let(:params) do {
      name: "subject1",
      weekly_hours: 1.5,
      total_hours: 1.5
    }
    end

    context 'with valid params' do
      before do
        post "/api/v_desktop/subjects/create", params: { subject: params }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:created)
      end

      it "creates the subject" do
        new_subject = Subject.find_by(name: "subject1")
        expect(new_subject).to_not be_nil
      end
    end
    
  end

  describe '/DELETE #DELETE' do
    let(:disciplina) {create(:subject, id: 1)}

    context "when subject exists" do
      before { delete "/api/v_desktop/subjects/delete/#{disciplina.id}" }

      it {expect(response).to have_http_status(200)}
      
      it "deletes the subject" do
        deleted_subject = Subject.find_by(id: 1)
        expect(deleted_subject).to be_nil
      end
    end

    context "when subject does not exist" do
      before do
        disciplina.destroy
        delete "/api/v_desktop/subjects/delete/#{disciplina.id}"
      end

      it {expect(response).to have_http_status(:bad_request)}
    end
  end

  describe "/PATCH #UPDATE" do
    let(:disciplina) { create(:subject, name: "Mulamba") }

    context "When subject exists" do
      before do
        patch "/api/v_desktop/subjects/update/#{disciplina.id}", params: { subject: {name: "Nome correto!"} }
      end

      it { expect(response).to have_http_status(200) }

      it "updates the subject" do
        updated_subject = Subject.find_by(id: disciplina.id)
        expect(updated_subject.name).to eq("Nome correto!")
      end
    end

    context "When subject does not exist" do
      before do
        disciplina.destroy
        patch "/api/v_desktop/subjects/update/#{disciplina.id}", params: { subject: {name: "Nome correto!"} }
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe "/GET #my_times" do
    #let(:disciplina) { create(:subject, id: 1) }
    #let(:working_time) { create(:subject, id: 1) }

    before do
      create(:subject, id: 1)
      create(:working_time, subject_id: 1)
      create(:working_time, subject_id: 1)
      create(:working_time, subject_id: 1)
      get "/api/v_desktop/subjects/my_times/1"
    end

    context "when subject exists" do
      
      it { expect(response).to have_http_status(200) }

      it "returns a json" do
          expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it 'returns 3 elements' do
        expect(JSON.parse(response.body).size).to eq(3)
      end 

    end

    context "when subject does not exist" do
      before do 
        Subject.find_by(id: 1).destroy
        get "/api/v_desktop/subjects/my_times/1"
      end

      it { expect(response).to have_http_status(:not_found) }

      it "Does not return a json" do
        expect(response.content_type).not_to eq("application/json; charset=utf-8")
      end
    end

  end
end
