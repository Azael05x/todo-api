class V1::TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /api/v1/tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /api/v1/tags/1
  def show
    render json: @tag
  end

  # POST /api/v1/tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # PATCH/PUT /api/v1/tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # DELETE /api/v1/tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title])
    end
end
