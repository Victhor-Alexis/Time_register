class Api::VDesktop::WorkingTimesController < ApplicationController
    def index
        wTimes = WorkingTime.all
        render json: wTimes, status: :ok
    end

    def show
        wtime = WorkingTime.find(params[:id])
        render json: wtime, status: :ok
    rescue StandardError
        head(:not_found)
    end

    def create
        wtime = WorkingTime.new(wtime_params)
        wtime.save!
        render json: wtime, status: 201
    rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
    end

    def delete
        wtime = WorkingTime.find(params[:id])
        wtime.destroy!
        render json: wtime, status: 200
    rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
    end

    def update
        wtime = WorkingTime.find(params[:id])
        wtime.update!(wtime_params)
        render json: wtime, status: 200
    rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity 
    end

    private

    def wtime_params
        params.require(:working_time).permit(
            :day,
            :time_i,
            :time_e,
            :subject_id
        )
    end
end
