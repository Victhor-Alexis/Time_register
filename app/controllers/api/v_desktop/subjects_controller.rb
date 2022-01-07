class Api::VDesktop::SubjectsController < ApplicationController
    def index
        subjects = Subject.all
        render json: subjects, status: 200
    end

    def show
        subject = Subject.find(params[:id])
        render json: subject, status: :ok
    rescue StandardError
        head(:not_found)
    end
    
    def create 
        subject = Subject.new(subject_params)
        subject.save!
        render json: subject, status: 201
    rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
    end

    def update
        subject = Subject.find(params[:id])
        subject.update!(subject_params)
        render json: subject, status: 200
    rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
    end

    def delete
        subject = Subject.find(params[:id])
        subject.destroy!
        render json: subject, status: 200
    rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
    end

    def my_times
        subject = Subject.find(params[:id])
        render json: subject.working_times, status: 200
    rescue StandardError
        head(:not_found)
    end

    private

    def subject_params
        params.require(:subject).permit(
            :name,
            :weekly_hours,
            :total_hours
        )
    end
end
