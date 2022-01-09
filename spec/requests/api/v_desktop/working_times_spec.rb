require 'rails_helper'

RSpec.describe "Api::VDesktop::WorkingTimes", type: :request do
  describe "GET /index" do
    before do
      create(:subject, id: 1)
      create(:working_time, subject_id: 1)
      create(:working_time, subject_id: 1)
      create(:working_time, subject_id: 1)
      create(:working_time, subject_id: 1)
      get '/api/v_desktop/working_times/index'
    end

    it { expect(response).to have_http_status(200) }

    it "should return a json object" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end  

    it "should return 3 elements" do
      expect(JSON.parse(response.body).size).to eq(4)
    end
  end

  describe "GET /show" do
    let(:tempo) { create(:working_time, subject_id: 1) }

    before do
      create(:subject, id: 1)
      get "/api/v_desktop/working_times/show/#{tempo.id}"
    end

    context "when working_time exists" do
      it { expect(response).to have_http_status(200) }
      
      it "returns a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "when working_time does not exist" do
      before do
        tempo.destroy
        get "/api/v_desktop/working_times/show/#{tempo.id}"
      end

      it {expect(response). to have_http_status(:not_found)}

      it "does not return a json" do
        expect(response.content_type).not_to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "POST /create" do
    let(:params) do {
      day: "Terça-feira",
      time_i: "12:00:00",
      time_e: "14:00:00",
      subject_id: 1
    } 
    end
    
    before { create(:subject, id: 1) }

    context "with valid params" do
      before do
        post '/api/v_desktop/working_times/create', params: { working_time: params }
      end

      it { expect(response).to have_http_status(201) } # return success response

      it  "really creates a new working_time" do
        new_wTime = WorkingTime.find_by(day: "Terça-feira")
        expect(new_wTime).not_to be_nil
      end
    end
  end

  describe "DELETE /delete" do 
    let(:wt) { create(:working_time, subject_id: 1) }

    before { create(:subject, id: 1) }

    context "when working_time exists" do
      before { delete "/api/v_desktop/working_times/delete/#{wt.id}" }

      it {expect(response).to have_http_status(200)}

      it "returns a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "will really delete the working_time" do
        deleted_subject = WorkingTime.find_by(id: wt.id)  
        expect(deleted_subject).to eq(nil)
      end
    end

    context "when working_time does not exist" do
      before do
        wt.destroy!
        delete "/api/v_desktop/working_times/delete/#{wt.id}"
      end

      it { expect(response).to have_http_status(400) }

    end
  end

  describe "PATCH /update" do
    let(:wt) { create(:working_time, subject_id: 1, day: "Friday") }

    before { create(:subject, id: 1) }

    context "when working_time exists" do
      
      before { patch "/api/v_desktop/working_times/update/#{wt.id}", params: { working_time: { day: "Saturday" } } }

      it { expect(response).to have_http_status(200) }

      it "updates the working_time" do
        updated_wt = WorkingTime.find_by(subject_id: 1)
        expect(updated_wt.day).to eq("Saturday")
      end

    end

    context "when working_time does not exist" do
      before do
        wt.destroy!
        patch "/api/v_desktop/working_times/update/#{wt.id}", params: { working_time: { day: "Saturday" } }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

    end
  end
end
