class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @groups = Group.includes(:settlements).where(user_id: current_user.id).order(updated_at: :desc)
  end

  def show
    redirect_to new_group_settlement_path(@group)
  end

  def new
    @group = current_user.groups.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to group_url(@group), notice: 'Group was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_url(@group), notice: 'Group was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
